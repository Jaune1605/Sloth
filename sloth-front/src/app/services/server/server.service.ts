import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { first } from 'rxjs/operators';
import {Router} from "@angular/router";



@Injectable({
  providedIn: 'root'
})
export class ServerService {

  private serverArray: any[] = [];
  private serverLoadingStatus: any[] = [];

  private _maskIp: string = "/16"; // Masque de sous-réseau (réseau de l'ESIEE)
  private _prefixIp: string = "10.18."; // Préfix de l'adresse IP (réseau de l'ESIEE)
  private _forbiddenIps: string[] = [
    "10.18.255.254"+this.maskIp, // Broadcast
    "10.18.0.253"+this.maskIp, // Reserved
    "10.18.0.0"+this.maskIp, // Network
  ];

  get maskIp(): string {
    return this._maskIp;
  }

  set maskIp(value: string) {
    this._maskIp = value;
  }

  get prefixIp(): any {
    return this._prefixIp;
  }

  set prefixIp(value: any) {
    this._prefixIp = value;
  }


  constructor (private http: HttpClient,
               private router: Router
               ) {

    this.refreshServerArray();
  }

  /**
   * Get the loading status of a server
   * @param serverName
   */
  getServerLoadingStatus(serverName: string) {
    const server = this.serverLoadingStatus.find((s) => s.name === serverName);
    return server ? server.loading : false;
  }

  /**
   * Refresh the server array
   */
  refreshServerArray() {
    this.http.get('http://127.0.0.1:8000/sloth/instances')
      .pipe(first())
      .subscribe((servers: any) => {
        this.serverArray = servers;
        this.serverLoadingStatus = servers.map((server: any) => ({ name: server.name, loading: false }));
      });
  }

  /**
   * @returns the servers
   */
  getServers() {
    return this.serverArray;
  }

  /**
   * Delete a server
   * @param serverName
   * @param provider
   */
  deleteServers(serverName: string, provider: string) {
    if (provider === 'proxmox') {
      this.deleteProxmoxServer(serverName);
    } else if (provider === 'aws') {
      this.deleteAwsServer(serverName);
    } else {
      console.error('Provider not supported');
    }
  }

  /**
   * Create a server according to the provider
   * @param serverData
   * @param provider
   */
  addServer(serverData: any, provider : any) {
    if (provider === 'aws') {
      this.addAwsServer(serverData);
    }
    else if (provider === 'proxmox') {
      this.addProxmoxServer(serverData);
    }else{
      console.error('Provider not supported');
    }
  }

  /**
   * Add a Proxmox server
   * @param serverData
   */
addProxmoxServer(serverData: any) {
    let server = {
      //type: "proxmox",
      name: serverData.serverName,
      node_name: "infra",
      username: serverData.username,
      password: serverData.password,
      datastore_id: "local-lvm",
      file_id: "local:iso/ubuntu-22.10-server-cloudimg-amd64.img",
      interface: "virtio0",
      iothread: "true",
      discard: "on",
      size: serverData.diskSize,
      cores: serverData.cpu,
      memory: serverData.cpu,
      ipAddress: this._prefixIp + serverData.ipAddress,
    };

    let response = null;

    this.http.post('http://127.0.0.1:8000/sloth/instances/proxmox', server)
      .pipe(first())
      .subscribe({
        next: () => {
          this.refreshServerArray();
          console.log('Instance added successfully on proxmox.');
          alert('Proxmox instance added successfully!');
          this.router.navigate(['/infrastructure-page']);
        },
        error: () => {
          console.error('Error adding instance on proxmox');
          alert('Error adding instance on proxmox');
        }
      });

    return response;
  }
  /**
   * Add an AWS server
   * @param serverData
   */
  addAwsServer(serverData: any) {
    let server = {
      name : serverData.serverName,
      type:  "t2.micro",
      ami:  "ami-00c71bd4d220aa22a",
      region: "eu-west-3"
    }

    console.log("Server Spec : \n\t",server);

    let response = null;

    response = this.http.post('http://127.0.0.1:8000/sloth/instances/aws', server)
      .pipe(first())
      .subscribe({
        next: () => {
          this.refreshServerArray();
          console.log('Instance added successfully on AWS.');
          alert('AWS instance added successfully!');
          this.router.navigate(['/infrastructure-page']);
        },
        error: () => {
          console.error('Error adding instance on AWS');
          alert('Error adding instance on AWS');
        }
      });

    return response;
  }

  /**
   * Delete a Proxmox server
   * @param serverName
   */
  deleteProxmoxServer(serverName: string) {
    const server = this.serverLoadingStatus.find((s) => s.name === serverName);
    if (server) {
      server.loading = true;
      this.http.delete(`http://127.0.0.1:8000/sloth/instances/Proxmox/${serverName}`).subscribe({
        next: () => {
          server.loading = false;
          this.refreshServerArray();
          console.log('Instance deleted successfully on proxmox.');
          alert('Proxmox instance deleted successfully!');
        },
        error: () => {
          server.loading = false;
          console.error('Error deleting instance on proxmox');
          alert('Error deleting instance on proxmox');
        }
      });
    }
  }

  /**
   * Delete an AWS server
   * @param serverName
   */
  deleteAwsServer(serverName: string) {
    const server = this.serverLoadingStatus.find((s) => s.name === serverName);
    if (server) {
      server.loading = true;
      this.http.delete(`http://127.0.0.1:8000/sloth/instances/aws/${serverName}`)
        .pipe(first())
          .subscribe({
            next: () => {
              server.loading = false;
              this.refreshServerArray();
              console.log('Instance deleted successfully on AWS.');
              alert('AWS instance deleted successfully!');
            },
            error: () => {
              server.loading = false;
              console.error('Error deleting instance on AWS');
              alert('Error deleting instance on AWS');
            }
          });
    }
  }











  /**
   * Get the servers sorted by provider
   */
  getServersSortedByProvider(): any[] {
    return this.getServers().sort((a, b) => a.provider.localeCompare(b.provider));
  }

  /**
   * Get the servers Filtered by provider
   */
  getServersFilteredByProvider(provider: string): any[] {
    return this.getServers().filter(server => server.provider === provider);
  }




  // Méthodes de vérication des champs du formulaire
  /**
   * Check if the IP is authorized
   * (i.e. if it exists in the server array or if it is a reserved IP)
   * @param submittedIp
   */
  isIpAvailable(submittedIp: string) {
    if (this._forbiddenIps.includes(submittedIp)  || this.serverArray.find((server) => server.ip === submittedIp)){
      console.log("Forbidden IP");
      return false;
    }
    return true;
  }

  /**
   * Check if the IP is valid
   * (i.e. if it is a valid IP address defined by the regex)
   * @param submittedIp
   */
  isIpRegexValid(submittedIp: string) {
    const ipRegex = new RegExp('^10\\.18\\.([0-9]{1,3})\\.([0-9]{1,3})/16$');
    return ipRegex.test(submittedIp);
  }


  /**
   * Check if the name is available
   * (i.e. if it exists in the server array)
   * @param submittedName
   */
  isNameAvailable(submittedName: string) {
    return !this.serverArray.find((server) => server.name === submittedName);
  }

  /**
   * Check if the name is valid
   * (i.e. if it is a valid name defined by the regex)
   * @param submittedName
   */
  isNameRegexValid(submittedName: string) {
    const nameRegex = new RegExp('^[a-zA-Z0-9_-]{3,16}$');
    return nameRegex.test(submittedName);
  }



}

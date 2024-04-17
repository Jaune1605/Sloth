import { Component, Input } from '@angular/core';
import { ServerService } from '../../../services/server/server.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-server-infos',
  templateUrl: './server-infos.component.html',
  styleUrl: './server-infos.component.css'
})
export class ServerInfosComponent {


  @Input("server")
  server: any;

  constructor(
    protected serverService: ServerService,
    protected router: Router
    ) { }

  /**
   * Delete a server
   * @param serverName
   * @param serverProvider
   */
  deleteServer(serverName: string, serverProvider: string) {
    this.serverService.deleteServers(serverName, serverProvider);
  }

  configureServer(serverId: string) {
    this.router.navigate(['/admin/configure', serverId]);
    console.log("Configure server with id: " + serverId);
  }


}


import {Component, Input, OnInit} from '@angular/core';
import {ServerService} from "../../../services/server/server.service";
import { ActivatedRoute } from '@angular/router';


@Component({
  selector: 'app-configure-page',
  templateUrl: './configure-page.component.html',
  styleUrl: './configure-page.component.css'
})
export class ConfigurePageComponent implements OnInit {

  protected server: any;
  protected serverId: any;
  protected selectedPlaybook: any;
  protected playbooks: any;

  constructor(
    private route: ActivatedRoute,
    protected serverService: ServerService
  ) { }

  ngOnInit(): void {
    this.serverId = this.route.snapshot.paramMap.get('id');
    this.serverService.refreshPlaybookArray();
    this.playbooks = this.serverService.getPlaybooks();
    this.update();
  }

  update(){
    this.server = this.serverService.getServerById(this.serverId);
    this.playbooks = this.serverService.getPlaybooks();
    console.log(this.server);
    console.log(this.playbooks);
    return this.server;
  }


  runSelectedPlaybook(){
    const host = this.server.ip.split('/')[0].replace(/\./g, '-');
    this.serverService.runPlaybook(host, this.selectedPlaybook);
  }

}

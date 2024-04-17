import { Component, Input } from '@angular/core';
import { ServerService } from '../../../services/server/server.service';

@Component({
  selector: 'app-server-infos',
  templateUrl: './server-infos.component.html',
  styleUrl: './server-infos.component.css'
})
export class ServerInfosComponent {

  isConfigPanelOpen = false;

  openConfigurationPanel() {
    this.isConfigPanelOpen = true;
  }

  closePanel() {
    this.isConfigPanelOpen = false;
  }

  @Input("server")
  server: any;

  constructor(protected serverService: ServerService) { }

  /**
   * Delete a server
   * @param serverName
   * @param serverProvider
   */
  deleteServer(serverName: string, serverProvider: string) {
    this.serverService.deleteServers(serverName, serverProvider);
  }

}

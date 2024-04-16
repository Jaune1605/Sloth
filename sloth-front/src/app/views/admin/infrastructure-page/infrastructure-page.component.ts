import { Component, Input, Output, EventEmitter } from '@angular/core';
import { ServerService } from '../../../services/server/server.service';

@Component({
  selector: 'app-infrastructure-page',
  templateUrl: './infrastructure-page.component.html',
  styleUrl: './infrastructure-page.component.css'
})
export class InfrastructurePageComponent {

  protected _filteredProvider: string = '';

  setFilteredProvider(target: any) {
    this._filteredProvider = target.provider;
  }

  constructor(protected serverService: ServerService) { }
  @Input() server: any; // Le serveur à afficher
  @Output() closeRequest = new EventEmitter();

  close() {
    this.closeRequest.emit();
  }
}

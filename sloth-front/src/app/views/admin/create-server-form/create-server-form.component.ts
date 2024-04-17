import {Component, OnInit} from '@angular/core';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {ServerService} from '../../../services/server/server.service';
import {HttpClientModule} from '@angular/common/http';
import {NgIf} from "@angular/common";
import {ProxmoxFormComponent} from "../../../components/servers/proxmox-form/proxmox-form.component";
import {AwsFormComponent} from "../../../components/servers/aws-form/aws-form.component";

@Component({
  selector: 'app-create-server-form',
  imports: [ReactiveFormsModule, FormsModule, HttpClientModule, NgIf, ProxmoxFormComponent, AwsFormComponent],
  templateUrl: './create-server-form.component.html',
  styleUrl: './create-server-form.component.css'
})
export class CreateServerFormComponent implements OnInit {

  currentProvider: string = 'proxmox';

  constructor(protected serverService: ServerService) { }

  ngOnInit() {

  }

  onProviderChange(target: any) {
    this.currentProvider = target.value;
  }




}

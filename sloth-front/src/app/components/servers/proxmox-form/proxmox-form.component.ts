import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {ServerService} from "../../../services/server/server.service";
import {ValidatorsService} from "../../../services/validators/validators.service";

@Component({
  selector: 'app-proxmox-form',
  templateUrl: './proxmox-form.component.html',
  styleUrl: './proxmox-form.component.css'
})
export class ProxmoxFormComponent implements OnInit{

  proxmoxForm: FormGroup = new FormGroup({});

  constructor(private validatorService : ValidatorsService,
              private serverService : ServerService
              ) {

  }

  ngOnInit(): void {

    this.proxmoxForm = new FormGroup({
      'serverName': new FormControl(null, [Validators.required, this.validatorService.nameValidator()]),
      'os': new FormControl(null, [Validators.required]),
      'username': new FormControl(null, [Validators.required]),
      'password': new FormControl(null, [Validators.required]),
      'ipAddress': new FormControl(null, [Validators.required, this.validatorService.ipValidator()]),
      'diskSize': new FormControl(null, [Validators.required]),
      'ram': new FormControl(null, [Validators.required]),
      'cpu': new FormControl(null, [Validators.required]),
    });

  }

  /**
   * Submit the form
   */
  onSubmit() {
    if(this.proxmoxForm.invalid){
      console.log("Invalid form")
      return;
    }else{
      console.log("Valid form")
      this.serverService.addServer(this.proxmoxForm.value, 'proxmox');
    }
  }


}

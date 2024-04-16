import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroup, Validators} from "@angular/forms";
import {ValidatorsService} from "../../../services/validators/validators.service";
import {ServerService} from "../../../services/server/server.service";

@Component({
  selector: 'app-aws-form',
  templateUrl: './aws-form.component.html',
  styleUrl: './aws-form.component.css'
})
export class AwsFormComponent implements OnInit{

  awsForm: FormGroup = new FormGroup({});

  constructor(private validatorService : ValidatorsService,
              private serverService : ServerService){

  }


  ngOnInit(): void {
    this.awsForm = new FormGroup({
      'serverName': new FormControl(null, [Validators.required, this.validatorService.nameValidator()]),
      'type': new FormControl(null, [Validators.required]),
      'region': new FormControl(null, [Validators.required]),
      'ami': new FormControl(null, [Validators.required]),
    });
  }

  /**
   * Submit the form
   */
  onSubmit() {
    if(this.awsForm.invalid){
      console.log("Invalid form")
      return;
    }else{
      console.log("Valid form")
      this.serverService.addServer(this.awsForm.value, 'aws');
    }
  }

}

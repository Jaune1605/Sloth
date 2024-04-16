import { Injectable } from '@angular/core';
import {ServerService} from "../server/server.service";
import {AbstractControl, ValidatorFn} from "@angular/forms";

@Injectable({
  providedIn: 'root'
})
export class ValidatorsService {

  constructor(private serverService: ServerService) {}

  /**
   * Custom validator for the IP address
   * @returns ValidatorFn
   */
  ipValidator(): ValidatorFn {
    return (control: AbstractControl): { [key: string]: any } | null => {
      let ip = this.serverService.prefixIp + control.value + this.serverService.maskIp;
      if (this.serverService.isIpAvailable(ip) && this.serverService.isIpRegexValid(ip)) {
        console.log("Valid IP");
        return null;
      } else {
        console.log("Invalid IP");
        return { 'invalidIp': { value: ip } };
      }
    };
  }

  /**
   * Custom validator for the server name
   * @returns ValidatorFn
   */
  nameValidator(): ValidatorFn {
    return (control: AbstractControl): { [key: string]: any } | null => {
      let name = control.value;
      if (this.serverService.isNameAvailable(name) && this.serverService.isNameRegexValid(name)) {
        console.log("Valid name");
        return null;
      } else {
        console.log("Invalid name");
        return { 'invalidName': { value: name } };
      }
    };
  }

}

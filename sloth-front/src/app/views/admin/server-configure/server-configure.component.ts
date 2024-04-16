import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormArray } from '@angular/forms';

@Component({
  selector: 'app-server-configure',
  templateUrl: './server-configure.component.html',
  styleUrls: ['./server-configure.component.css']
})
export class ServerConfigureComponent implements OnInit {
  
  @Input("server")
  server: any;
  
  servicesForm: FormGroup = new FormGroup({});
  
  availableServices = [
    { id: 1, name: 'SSH' },
    { id: 2, name: 'UFW' },
    { id: 3, name: 'CLAMAV' },
    { id: 4, name: 'NGINX Reverse Proxy' }
    // Ajouter d'autres services selon les besoins
  ];

  constructor(private fb: FormBuilder) {}

  ngOnInit() {
    this.servicesForm = this.fb.group({
      services: this.fb.array([])
    });
    this.addService(); // Initialiser avec un champ de sélection
  }

  get services(): FormArray {
    return this.servicesForm.get('services') as FormArray;
  }

  addService() {
    this.services.push(this.fb.control(''));
  }

  removeService(index: number) {
    this.services.removeAt(index);
  }

  onSubmit() {
    console.log(this.servicesForm.value);
    // Logique pour envoyer les données au serveur ou exécuter le playbook Ansible
  }
}

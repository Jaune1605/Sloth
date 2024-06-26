import { Component, OnInit, inject } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { OidcSecurityService } from 'angular-auth-oidc-client';

@Component({
  selector: "app-auth-navbar",
  templateUrl: "./auth-navbar.component.html",
})
export class AuthNavbarComponent implements OnInit {
  private readonly oidcSecurityService = inject(OidcSecurityService);
  isAuthenticated = false;  // Ajout pour suivre l'état d'authentification
  navbarOpen = false;
  title = "angular-dashboard-page";

  constructor() {
    this.oidcSecurityService.checkAuth().subscribe(({ isAuthenticated }) => {
      this.isAuthenticated = isAuthenticated;  // Mettre à jour l'état d'authentification
      console.log('Auth Status Updated:', isAuthenticated);
    });
  }    

  ngOnInit() {
    this.oidcSecurityService.checkAuth().subscribe(({ isAuthenticated, userData, accessToken }) => {
      console.log('Auth Status:', isAuthenticated);
      console.log('User Data:', userData);
      console.log('Access Token:', accessToken);

      var token = this.oidcSecurityService.getAccessToken()

      // Effectuez des actions supplémentaires ici en fonction de l'état d'authentification
      //if (!isAuthenticated) this.login();
    });
  }
  setNavbarOpen() {
    this.navbarOpen = !this.navbarOpen;
  }
  login() {
    this.oidcSecurityService.authorize();
  }

  logout() {
    this.oidcSecurityService.logoff().subscribe((result) => console.log(result));
    this.isAuthenticated = false; 
    
  }
}

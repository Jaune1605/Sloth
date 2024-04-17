import { Component, OnInit, inject } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { OidcSecurityService } from 'angular-auth-oidc-client';

@Component({
  selector: "app-auth-navbar",
  templateUrl: "./auth-navbar.component.html",
})
export class AuthNavbarComponent implements OnInit {
  private readonly oidcSecurityService = inject(OidcSecurityService);

  title = "angular-dashboard-page";

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

  login() {
    this.oidcSecurityService.authorize();
  }

  logout() {
    this.oidcSecurityService.logoff().subscribe((result) => console.log(result));
  }
}

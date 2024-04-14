// login.component.ts
import { Component, OnInit } from '@angular/core';
import { OidcSecurityService } from 'angular-auth-oidc-client';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
})
export class LoginComponent implements OnInit {
  constructor(private oidcSecurityService: OidcSecurityService, private router: Router) {}

  ngOnInit(): void {
    this.oidcSecurityService.isAuthenticated$.subscribe(({ isAuthenticated }) => {
      if (isAuthenticated) {
        this.oidcSecurityService.userData$.subscribe(({ userData }) => {
          if (userData) {
            const roles = this.getRoles(userData);
            this.redirectBasedOnRole(roles);
          }
        });
      }
    });
  }

  private getRoles(userData: any): string[] {
    return Array.isArray(userData.role) ? userData.role : [userData.role];
  }

  login() {
    this.oidcSecurityService.authorize(); // Redirige vers Keycloak
  }

  private redirectBasedOnRole(roles: string[]): void {
    if (roles.includes('admin')) {
      this.router.navigate(['/admin/dashboard']);
    } else if (roles.includes('client')) {
      this.router.navigate(['/profile']); // Remplacez ceci par la route du tableau de bord client
    } else {
      this.router.navigate(['/']); // Page d'accueil pour les rôles non spécifiés
    }
  }
}

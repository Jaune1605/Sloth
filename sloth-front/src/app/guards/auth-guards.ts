import { inject } from '@angular/core';
import { Router } from '@angular/router';
import { OAuthService } from 'angular-oauth2-oidc';

export function authGuard() {
  const oauthService = inject(OAuthService);
  const router = inject(Router);

  return () => {
    if (oauthService.hasValidAccessToken()) {
      return true;
    } else {
      router.navigate(['/auth']);
      return false;
    }
  };
}

export function adminGuard() {
  const oauthService = inject(OAuthService);
  const router = inject(Router);

  return () => {
    const hasRole = oauthService.getIdentityClaims()?.['role'] === 'admin';
    if (oauthService.hasValidAccessToken() && hasRole) {
      return true;
    } else {
      router.navigate(['/auth']);
      return false;
    }
  };
}

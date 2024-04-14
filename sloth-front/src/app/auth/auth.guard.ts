// auth.guard.ts
import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { Observable, of } from 'rxjs';
import { map, switchMap, catchError, take } from 'rxjs/operators';
import { OidcSecurityService } from 'angular-auth-oidc-client';

@Injectable({
  providedIn: 'root',
})
export class RoleBasedRedirectGuard implements CanActivate {
  constructor(private oidcSecurityService: OidcSecurityService, private router: Router) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean> {
    return this.oidcSecurityService.isAuthenticated$.pipe(
      take(1),
      switchMap(({ isAuthenticated }) => {
        if (isAuthenticated) {
          return this.oidcSecurityService.userData$.pipe(
            map(({ userData }) => {
              const roles = this.getRoles(userData);
              return this.handleAuth(roles);
            }),
            catchError((error) => {
              console.error('Error in userData observable', error);
              this.router.navigate(['/auth/login']);
              return of(false);
            })
          );
        } else {
          this.router.navigate(['/auth/login']);
          return of(false);
        }
      })
    );
  }

  private handleAuth(roles: string[]): boolean {
    if (roles.includes('admin')) {
      this.router.navigate(['/admin/dashboard']);
    } else {
      this.router.navigate(['/profile']);
    }
    return true; // Redirecting manually above, return true here to allow navigation
  }

  private getRoles(userData: any): string[] {
    // Extract roles from userData; this will vary based on your token structure
    const roles = userData.role || userData.roles || [];
    return Array.isArray(roles) ? roles : [roles];
  }
}

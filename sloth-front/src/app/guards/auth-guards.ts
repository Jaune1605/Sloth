import { Injectable, inject } from '@angular/core';
import {
  ActivatedRouteSnapshot,
  CanActivate,
  Router,
  RouterStateSnapshot,
  UrlTree,
} from '@angular/router';
import { OidcSecurityService } from 'angular-auth-oidc-client';
import { Observable } from 'rxjs';
import { map, switchMap, catchError, take } from 'rxjs/operators';


@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
  private readonly oidcSecurityService = inject(OidcSecurityService);
  private readonly router = inject(Router);

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): Observable<boolean | UrlTree> {
    return this.oidcSecurityService.isAuthenticated$.pipe(
      take(1),
      map(({ isAuthenticated }) => {
        // allow navigation if authenticated
        if (isAuthenticated) {
          return true;
        }
    

        // redirect if not authenticated
        // innit connexion with keycloak et redirect to current url locked
        this.oidcSecurityService.authorize();
        if (isAuthenticated) {
            return true;
        }else {
            return this.router.parseUrl('/landing');
        }
        //return this.router.parseUrl('/landing');
      })
    );
  }
}
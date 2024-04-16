import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { OidcSecurityService } from 'angular-auth-oidc-client';
import { Observable, throwError } from 'rxjs';
import { catchError, switchMap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ApiService {
  private apiURL = 'http://10.18.0.253:8080/api/problems';

  constructor(private http: HttpClient, private oidcSecurityService: OidcSecurityService) {}

  sendProblem(question: string): Observable<any> {
    return this.oidcSecurityService.checkAuth().pipe(
      switchMap(({ accessToken }) => {
        if (!accessToken) {
          return throwError('No access token available');
        }
        console.log('Access Token:', accessToken);
        console.log('Sending question:', question);
        
        const headers = new HttpHeaders({
          'Authorization': `Bearer ${accessToken}`,
          'Content-Type': 'application/json'
        });

        const body = {
          phrase: question // Format the question as required
        };

        return this.http.post(this.apiURL, body, { headers });
      }),
      catchError(error => {
        console.error('Error in making request: ', error);
        return throwError(error);
      })
    );
  }
}

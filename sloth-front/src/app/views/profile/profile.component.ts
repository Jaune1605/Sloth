import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/apiIA.service';
import { NgForm } from '@angular/forms';


@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html'
})
export class ProfileComponent implements OnInit {
  predictions: any[] = [];
question: any;

  constructor(private apiService: ApiService) {}

  ngOnInit(): void {}

  onSubmit(form: NgForm): void {
    if (form.valid) {
      this.apiService.sendProblem(form.value.question).subscribe({
        next: (response) => {
          this.predictions = response;
          console.log('API Response:', response);
          console.log('Predictions:', this.predictions);
        },
        error: (error) => {
          console.error('Error fetching data:', error);
        }
      });
    }
  }

  getOpacity(index: number): number {
    // Linear decrease in opacity for each prediction, starting from 1 to 0.2
    return Math.max(1 - 0.2 * index, 0.2);
  }
}

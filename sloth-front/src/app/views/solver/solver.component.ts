import { Component, OnInit } from '@angular/core';
import { ApiService } from '../../services/apiIA.service';
import { NgForm } from '@angular/forms';


@Component({
  selector: 'app-solver',
  templateUrl: './solver.component.html'
})
export class SolverComponent implements OnInit {
  predictions: any[] = [];
  question: any;
  selectedPrediction: any = null;

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

  /*
  selectPrediction(selectedPrediction: any): void {
    // Ensure that `problem` and `solution` are sent as strings.
    const dataToSend = {
      problem: this.question, // The question asked
      solution: selectedPrediction.label // The label of the chosen prediction
    };

    this.apiService.submitProblemSolution(dataToSend.problem, dataToSend.solution).subscribe({
      next: (response) => {
        console.log('Data submitted successfully:', response);
      },
      error: (error) => {
        console.error('Error submitting data to API:', error);
      }
    });
  }
  */
  selectPrediction(prediction: any): void {
    this.selectedPrediction = prediction;
  }

  submitSelection(): void {
    if (this.selectedPrediction) {
      this.apiService.submitProblemSolution(this.question, this.selectedPrediction.label).subscribe({
        next: (response) => {
          console.log('Data submitted successfully:', response);
          this.reset();
        },
        error: (error) => {
          console.error('Error submitting data to API:', error);
        }
      });
    }
  }

  reset(): void {
    // Réinitialisez l'état initial après la soumission
    this.predictions = [];
    this.selectedPrediction = null;
    this.question = ''; // Réinitialiser la question si nécessaire
  }
  

  getOpacity(index: number): number {
    // Linear decrease in opacity for each prediction, starting from 1 to 0.2
    return Math.max(1 - 0.2 * index, 0.2);
  }
}

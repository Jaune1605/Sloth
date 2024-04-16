import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AwsFormComponent } from './aws-form.component';

describe('AwsFormComponent', () => {
  let component: AwsFormComponent;
  let fixture: ComponentFixture<AwsFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AwsFormComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(AwsFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

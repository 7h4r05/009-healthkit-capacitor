import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { WatchOSSevice, WatchOsStatus } from './watch-os.service';

@Component({
  selector: 'app-root',
  templateUrl: 'app.component.html',
  styleUrls: ['app.component.scss'],
})
export class AppComponent implements OnInit {
  value: string = '';
  status: WatchOsStatus | null = null;
  hr: any = 0;
  constructor(
    private watchOsService: WatchOSSevice,
    private cd: ChangeDetectorRef
  ) {}

  async ngOnInit() {
    this.status = await this.watchOsService.getState();
  }

  async checkStatus() {
    this.status = await this.watchOsService.getState();
  }

  async subscribe() {
    await this.watchOsService.observeHR((result) => {
      this.hr = result?.heartRate ?? 0;
      this.cd.detectChanges();
    });
  }
}

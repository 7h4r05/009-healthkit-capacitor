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
  constructor(
    private watchOsService: WatchOSSevice,
    private cd: ChangeDetectorRef
  ) {}

  async ngOnInit() {
    this.watchOsService.subscribe((msg) => {
      this.value = msg?.value ?? this.value;
      this.cd.detectChanges();
    });
    this.status = await this.watchOsService.getState();
  }

  async sendValue() {
    await this.watchOsService.setValue({ value: this.value });
  }

  async checkStatus() {
    this.status = await this.watchOsService.getState();
  }
}

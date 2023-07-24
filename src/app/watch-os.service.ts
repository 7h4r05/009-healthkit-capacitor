import { Injectable } from '@angular/core';
import { CallbackID, Capacitor, registerPlugin } from '@capacitor/core';

export enum WatchOsStatus {
  OK = 0,
  NotSupported = 1,
  NotReachable = 2,
  NotPaired = 3,
  CommunicationProblem = 4,
  ActivationFailure = 5,
  WatchAppNotInstalled = 6,
}

export type SubscribeToValueCallback = (
  message: { value: string } | null,
  err?: any
) => void;

const _pluginName: string = 'WatchOSPlugin';

export interface WatchOSPlugin {
  getState(): Promise<{
    status: WatchOsStatus;
  }>;
  subscribe(callback: SubscribeToValueCallback): Promise<CallbackID>;
  setValue(data: { value: string }): Promise<void>;
}

const WatchOSPlugin = registerPlugin<WatchOSPlugin>(_pluginName);
@Injectable({
  providedIn: 'root',
})
export class WatchOSSevice {
  async getState(): Promise<WatchOsStatus> {
    if (!Capacitor.isPluginAvailable(_pluginName)) {
      return WatchOsStatus.NotSupported;
    }
    const result = await WatchOSPlugin.getState();
    return result ? result.status : WatchOsStatus.CommunicationProblem;
  }

  async subscribe(
    callback: SubscribeToValueCallback
  ): Promise<CallbackID | null> {
    if (Capacitor.isPluginAvailable(_pluginName)) {
      return await WatchOSPlugin.subscribe(callback);
    }
    return null;
  }
  async setValue(data: { value: string }): Promise<void> {
    if (Capacitor.isPluginAvailable(_pluginName)) {
      await WatchOSPlugin.setValue(data);
    }
  }
}

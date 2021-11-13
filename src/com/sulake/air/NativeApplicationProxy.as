package com.sulake.air
{
    import flash.events.EventDispatcher;
    import com.sulake.habbo.utils.air.INativeApplicationProxy;
    import flash.media.SoundMixer;
//    import flash.desktop.NativeApplication;
    import flash.events.Event;

    public class NativeApplicationProxy extends EventDispatcher implements INativeApplicationProxy
    {

        public static var isDeactivated:Boolean;
        public static var isSuspended:Boolean;

        public function NativeApplicationProxy()
        {
            SoundMixer.audioPlaybackMode = "ambient";
//            NativeApplication.nativeApplication.addEventListener("activate", onApplicationActivate);
//            NativeApplication.nativeApplication.addEventListener("deactivate", onApplicationDeactivate);
//            NativeApplication.nativeApplication.addEventListener("suspend", onApplicationSuspend);
        }

        public function dispose():void
        {
//            NativeApplication.nativeApplication.removeEventListener("activate", onApplicationActivate);
//            NativeApplication.nativeApplication.removeEventListener("deactivate", onApplicationDeactivate);
//            NativeApplication.nativeApplication.removeEventListener("suspend", onApplicationSuspend);
        }

        public function allowBackgroundExecution(_arg_1:Boolean):void
        {
//            NativeApplication.nativeApplication.executeInBackground = _arg_1;
        }

        private function onApplicationActivate(_arg_1:Event):void
        {
            this.dispatchEvent(new Event("NAE_application_active"));
            isDeactivated = false;
            isSuspended = false;
        }

        private function onApplicationSuspend(_arg_1:Event):void
        {
            this.dispatchEvent(new Event("NAE_application_suspend"));
            isSuspended = true;
        }

        private function onApplicationDeactivate(_arg_1:Event):void
        {
            this.dispatchEvent(new Event("NAE_application_deactive"));
            isDeactivated = true;
        }


    }
}

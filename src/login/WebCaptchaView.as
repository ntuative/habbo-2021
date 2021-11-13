package login
{
    import flash.display.Sprite;
    import com.sulake.habbo.communication.login.ICaptchaView;
//    import flash.media.StageWebView;
    import com.sulake.habbo.communication.login.ICaptchaListener;
    import flash.geom.Rectangle;
    import flash.events.Event;
//    import flash.events.LocationChangeEvent;

    public class WebCaptchaView extends Sprite implements ICaptchaView
    {

        private static const CAPTCHA_ENDPOINT:String = "/api/public/captcha";
        private static const TOKEN_KEY:String = "token=";

        private static var _SafeStr_4571:*;

        private var _SafeStr_1284:ICaptchaListener;

        public function WebCaptchaView(_arg_1:ICaptchaListener)
        {
//            _SafeStr_1284 = _arg_1;
//            addEventListener("addedToStage", onAddedToStage);
        }

        private static function resolveToken(_arg_1:String):String
        {
            var _local_2:int = ((_arg_1 != null) ? _arg_1.indexOf("token=") : -1);
            if (_local_2 < 0)
            {
                return (null);
            };
            return (_arg_1.substr((_local_2 + "token=".length)));
        }


        private function onAddedToStage(_arg_1:Event):void
        {
        }

        public function dispose():void
        {
        }

//        private function onLocationChange(_arg_1:LocationChangeEvent):void
        private function onLocationChange(_arg_1:*):void
        {
        }


    }
}
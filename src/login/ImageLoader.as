package login
{
    import flash.events.EventDispatcher;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.ErrorEvent;

    public class ImageLoader extends EventDispatcher 
    {

        private var _SafeStr_779:Loader;
        private var _SafeStr_780:String;

        public function ImageLoader(_arg_1:Loader, _arg_2:String)
        {
            _SafeStr_779 = _arg_1;
            _SafeStr_780 = _arg_2;
            var _local_3:URLRequest = new URLRequest(_arg_2);
            _arg_1.load(_local_3);
            _arg_1.contentLoaderInfo.addEventListener("complete", avatarImageLoadCompleteHandler);
            _arg_1.contentLoaderInfo.addEventListener("error", onImageError);
            _arg_1.contentLoaderInfo.addEventListener("ioError", onImageError);
            _arg_1.contentLoaderInfo.addEventListener("securityError", onImageError);
        }

        public static function CreateLoader(_arg_1:Loader, _arg_2:String, _arg_3:Function):ImageLoader
        {
            var _local_4:ImageLoader = new ImageLoader(_arg_1, _arg_2);
            _local_4.addEventListener("complete", _arg_3);
            return (_local_4);
        }


        private function avatarImageLoadCompleteHandler(_arg_1:Event):void
        {
            Logger.log(("[ImageLoader] Loaded image " + _SafeStr_780));
            dispatchEvent(new ImageLoaderEvent("complete", _SafeStr_779, _SafeStr_780));
        }

        private function onImageError(_arg_1:ErrorEvent):void
        {
            Logger.log(("[ImageLoader] Failed to load image " + _arg_1.text));
        }


    }
}


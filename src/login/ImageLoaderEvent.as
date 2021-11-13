package login
{
    import flash.events.Event;
    import flash.display.Loader;

    public class ImageLoaderEvent extends Event 
    {

        private var _loader:Loader;
        private var _url:String;

        public function ImageLoaderEvent(_arg_1:String, _arg_2:Loader, _arg_3:String)
        {
            _loader = _arg_2;
            _url = _arg_3;
            super(_arg_1, false, false);
        }

        public function get loader():Loader
        {
            return (_loader);
        }

        public function get url():String
        {
            return (_url);
        }


    }
}
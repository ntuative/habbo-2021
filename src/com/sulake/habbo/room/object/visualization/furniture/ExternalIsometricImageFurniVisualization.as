package com.sulake.habbo.room.object.visualization.furniture
{
    import flash.events.ErrorEvent;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import com.sulake.core.runtime.exceptions.Exception;
    import flash.display.LoaderInfo;
    import flash.display.Bitmap;
    import flash.events.Event;

    public class ExternalIsometricImageFurniVisualization extends IsometricImageFurniVisualization 
    {

        private var _SafeStr_3295:String = null;


        private static function onThumbnailError(_arg_1:ErrorEvent):void
        {
            Logger.log(("External Image thumbnail download error: " + _arg_1.toString()));
        }


        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:String;
            var _local_2:Loader;
            var _local_3:LoaderContext;
            if (object != null)
            {
                _local_4 = getThumbnailURL();
                if (_SafeStr_3295 != _local_4)
                {
                    _SafeStr_3295 = _local_4;
                    if (((!(_SafeStr_3295 == null)) && (!(_SafeStr_3295 == ""))))
                    {
                        _local_2 = new Loader();
                        _local_2.name = _local_4;
                        _local_2.contentLoaderInfo.addEventListener("complete", onThumbnailLoaded);
                        _local_2.contentLoaderInfo.addEventListener("ioError", onThumbnailError);
                        _local_2.contentLoaderInfo.addEventListener("securityError", onThumbnailError);
                        _local_3 = new LoaderContext(true);
                        _local_3.checkPolicyFile = true;
                        _local_2.load(new URLRequest(_local_4), _local_3);
                    }
                    else
                    {
                        setThumbnailImages(null);
                    };
                };
            };
            return (super.updateModel(_arg_1));
        }

        protected function getThumbnailURL():String
        {
            throw (new Exception("This method must be overridden!"));
        }

        private function onThumbnailLoaded(_arg_1:Event):void
        {
            var _local_3:LoaderInfo = (_arg_1.target as LoaderInfo);
            var _local_2:Bitmap = (_local_3.content as Bitmap);
            if (_local_2 != null)
            {
                setThumbnailImages(_local_2.bitmapData);
            }
            else
            {
                setThumbnailImages(null);
            };
        }


    }
}


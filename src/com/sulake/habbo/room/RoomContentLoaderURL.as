package com.sulake.habbo.room
{
    public class RoomContentLoaderURL implements IRoomContentLoaderURL 
    {

        private static const FILE_TYPE_PNG:String = "png";
        private static const FILE_TYPE_JPG:String = "png";
        private static const CACHE_KEY_FURNI_PREFIX:String = "furni/";
        private static const CACHE_KEY_ICON_PREFIX:String = "icon/";

        private var _url:String;
        private var _cacheKey:String;
        private var _cacheRevision:String;
        private var _assetName:String;
        private var _fileType:String;

        public function RoomContentLoaderURL(_arg_1:String, _arg_2:String=null, _arg_3:String=null, _arg_4:Boolean=false, _arg_5:String=null)
        {
            _url = _arg_1;
            var _local_7:String = ((_arg_4) ? "icon/" : "furni/");
            _cacheKey = ((_arg_2) ? (_local_7 + _arg_2) : null);
            _cacheRevision = _arg_3;
            _assetName = _arg_5;
            var _local_6:String = _arg_1.toLowerCase();
            if (_local_6.indexOf(".png") > -1)
            {
                _fileType = "png";
            }
            else
            {
                if (_local_6.indexOf(".jpg") > -1)
                {
                    _fileType = "png";
                }
                else
                {
                    if (_local_6.indexOf(".jpeg") > -1)
                    {
                        _fileType = "png";
                    };
                };
            };
        }

        public function get url():String
        {
            return (_url);
        }

        public function get cacheKey():String
        {
            return (_cacheKey);
        }

        public function get cacheRevision():String
        {
            return (_cacheRevision);
        }

        public function get assetName():String
        {
            return (_assetName);
        }

        public function get fileType():String
        {
            return (_fileType);
        }


    }
}
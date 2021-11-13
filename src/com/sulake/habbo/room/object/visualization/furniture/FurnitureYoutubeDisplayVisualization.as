package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObjectModel;
    import com.sulake.core.utils.Map;

    public class FurnitureYoutubeDisplayVisualization extends ExternalIsometricImageFurniVisualization 
    {

        protected static const THUMBNAIL_URL_KEY:String = "THUMBNAIL_URL";


        override protected function getThumbnailURL():String
        {
            var _local_3:IRoomObjectModel = object.getModel();
            var _local_2:Map = _local_3.getStringToStringMap("furniture_data");
            var _local_1:String = _local_3.getString("session_url_prefix");
            if (_local_1 == null)
            {
                return (null);
            };
            return (_local_1 + _local_2.getValue("THUMBNAIL_URL"));
        }


    }
}
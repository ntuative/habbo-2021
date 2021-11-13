package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class FurnitureGuildIsometricBadgeVisualization extends IsometricImageFurniVisualization 
    {

        private static const PRIMARY_COLOUR_SPRITE_TAG:String = "COLOR1";
        private static const SECONDARY_COLOUR_SPRITE_TAG:String = "COLOR2";
        private static const DEFAULT_COLOR_1:int = 0xEEEEEE;
        private static const DEFAULT_COLOR_2:int = 0x4B4B4B;

        private var _color1:int;
        private var _color2:int;


        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:String;
            var _local_5:Boolean = super.updateModel(_arg_1);
            if (!hasThumbnailImage)
            {
                _local_4 = object.getModel().getString("furniture_guild_customized_asset_name");
                if (_local_4 != null)
                {
                    setThumbnailImages(safeGetBitmapAsset(_local_4), safeGetBitmapAsset((_local_4 + "_32")));
                };
            };
            var _local_2:Number = object.getModel().getNumber("furniture_guild_customized_color_1");
            _color1 = ((isNaN(_local_2)) ? 0xEEEEEE : (_local_2 as int));
            var _local_3:Number = object.getModel().getNumber("furniture_guild_customized_color_2");
            _color2 = ((isNaN(_local_2)) ? 0x4B4B4B : (_local_3 as int));
            return (_local_5);
        }

        private function safeGetBitmapAsset(_arg_1:String):BitmapData
        {
            var _local_2:IGraphicAsset = assetCollection.getAsset(_arg_1);
            if (((_local_2 == null) || (_local_2.asset == null)))
            {
                return (null);
            };
            return (BitmapData(_local_2.asset.content));
        }

        override protected function getSpriteColor(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:String = getSpriteTag(_arg_1, direction, _arg_2);
            switch (_local_4)
            {
                case "COLOR1":
                    return (_color1);
                case "COLOR2":
                    return (_color2);
            };
            return (super.getSpriteColor(_arg_1, _arg_2, _arg_3));
        }

        override protected function getLibraryAssetNameForSprite(_arg_1:IGraphicAsset, _arg_2:IRoomObjectSprite):String
        {
            if (_arg_2.tag == "THUMBNAIL")
            {
                if (((object) && (object.getModel().getString("furniture_guild_customized_asset_name"))))
                {
                    return ("%group.badge.url%" + object.getModel().getString("furniture_guild_customized_asset_name").replace("badge_", ""));
                };
            };
            return (super.getLibraryAssetNameForSprite(_arg_1, _arg_2));
        }


    }
}
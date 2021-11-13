package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.visualization.utils.IGraphicAsset;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class FurnitureGuildCustomizedVisualization extends AnimatedFurnitureVisualization 
    {

        public static const PRIMARY_COLOUR_SPRITE_TAG:String = "COLOR1";
        public static const SECONDARY_COLOUR_SPRITE_TAG:String = "COLOR2";
        public static const DEFAULT_COLOR_1:int = 0xEEEEEE;
        public static const DEFAULT_COLOR_2:int = 0x4B4B4B;
        private static const BADGE_SPRITE_TAG:String = "BADGE";

        private var _color1:int;
        private var _color2:int;
        private var _SafeStr_3296:String = "";
        private var _SafeStr_3297:String = "";


        override protected function updateModel(_arg_1:Number):Boolean
        {
            var _local_4:String;
            var _local_5:Boolean = super.updateModel(_arg_1);
            if (_SafeStr_3296 == "")
            {
                _local_4 = object.getModel().getString("furniture_guild_customized_asset_name");
                if (_local_4 != null)
                {
                    _SafeStr_3296 = _local_4;
                    _SafeStr_3297 = (_SafeStr_3296 + "_32");
                };
            };
            var _local_2:Number = object.getModel().getNumber("furniture_guild_customized_color_1");
            _color1 = ((isNaN(_local_2)) ? 0xEEEEEE : (_local_2 as int));
            var _local_3:Number = object.getModel().getNumber("furniture_guild_customized_color_2");
            _color2 = ((isNaN(_local_2)) ? 0x4B4B4B : (_local_3 as int));
            return (_local_5);
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

        override protected function getSpriteAssetName(_arg_1:int, _arg_2:int):String
        {
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            if (_local_3 == "BADGE")
            {
                if (_arg_1 == 32)
                {
                    return (_SafeStr_3297);
                };
                return (_SafeStr_3296);
            };
            return (super.getSpriteAssetName(_arg_1, _arg_2));
        }

        override protected function getLibraryAssetNameForSprite(_arg_1:IGraphicAsset, _arg_2:IRoomObjectSprite):String
        {
            if (_arg_2.tag == "BADGE")
            {
                return ("%group.badge.url%" + _arg_2.assetName.replace("badge_", ""));
            };
            return (super.getLibraryAssetNameForSprite(_arg_1, _arg_2));
        }


    }
}


package com.sulake.habbo.room.object.visualization.game
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.SnowballVisualizationData;
    import com.sulake.room.object.visualization.IRoomObjectSprite;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;

    public class SnowballVisualization extends RoomObjectSpriteVisualization 
    {

        private static const SNOWBALL_ASSET_NAME:String = "snowball_small_png";
        private static const SNOWBALL_SHADOW_ASSET_NAME:String = "snowball_small_shadow_png";
        private static const _SafeStr_3404:int = 16;

        private var _SafeStr_690:SnowballVisualizationData;
        private var _SafeStr_3405:IRoomObjectSprite;


        override public function dispose():void
        {
            _SafeStr_3405 = null;
            super.dispose();
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            var _local_2:BitmapDataAsset;
            _SafeStr_690 = (_arg_1 as SnowballVisualizationData);
            createSprites(2);
            _local_2 = (_SafeStr_690.assets.getAssetByName("snowball_small_png") as BitmapDataAsset);
            getSprite(0).asset = (_local_2.content as BitmapData);
            _local_2 = (_SafeStr_690.assets.getAssetByName("snowball_small_shadow_png") as BitmapDataAsset);
            _SafeStr_3405 = getSprite(1);
            _SafeStr_3405.asset = (_local_2.content as BitmapData);
            _SafeStr_3405.alpha = 100;
            _SafeStr_3405.relativeDepth = 1;
            return (true);
        }

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            _SafeStr_3405.offsetY = (object.getLocation().z * 16);
            _SafeStr_3405.alpha = Math.max(0, (100 - (_SafeStr_3405.offsetY / 10)));
        }


    }
}


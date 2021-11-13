package com.sulake.habbo.room.object.visualization.game
{
    import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
    import com.sulake.habbo.room.object.visualization.furniture.SnowballVisualizationData;
    import com.sulake.core.assets.BitmapDataAsset;
    import flash.display.BitmapData;
    import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
    import com.sulake.room.utils.IRoomGeometry;

    public class SnowSplashVisualization extends RoomObjectSpriteVisualization 
    {

        private static const FRAME_ASSET_NAMES:Array = ["snowball_splash_1", "snowball_splash_2", "snowball_splash_3"];

        private var _frameNumber:int = 0;
        private var _SafeStr_690:SnowballVisualizationData;


        public function get isDone():Boolean
        {
            return (!(_frameNumber < FRAME_ASSET_NAMES.length));
        }

        override public function initialize(_arg_1:IRoomObjectVisualizationData):Boolean
        {
            var _local_2:BitmapDataAsset;
            _SafeStr_690 = (_arg_1 as SnowballVisualizationData);
            createSprites(1);
            _local_2 = (_SafeStr_690.assets.getAssetByName(FRAME_ASSET_NAMES[_frameNumber]) as BitmapDataAsset);
            getSprite(0).asset = (_local_2.content as BitmapData);
            return (true);
        }

        override public function update(_arg_1:IRoomGeometry, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            _frameNumber++;
            getSprite(0).asset = ((isDone) ? null : (_SafeStr_690.assets.getAssetByName(FRAME_ASSET_NAMES[_frameNumber]).content as BitmapData));
        }


    }
}


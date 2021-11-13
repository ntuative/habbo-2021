package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureCounterClockVisualization extends AnimatedFurnitureVisualization 
    {

        private static const SECONDS_SPRITE_TAG:String = "seconds_sprite";
        private static const TEN_SECONDS_SPRITE_TAG:String = "ten_seconds_sprite";
        private static const MINUTES_SPRITE_TAG:String = "minutes_sprite";
        private static const TEN_MINUTES_SPRITE_TAG:String = "ten_minutes_sprite";


        override public function get animationId():int
        {
            return (0);
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_4:String = getSpriteTag(_arg_1, direction, _arg_2);
            var _local_3:int = super.animationId;
            switch (_local_4)
            {
                case "seconds_sprite":
                    return ((_local_3 % 60) % 10);
                case "ten_seconds_sprite":
                    return ((_local_3 % 60) / 10);
                case "minutes_sprite":
                    return ((_local_3 / 60) % 10);
                case "ten_minutes_sprite":
                    return (((_local_3 / 60) / 10) % 10);
                default:
                    return (super.getFrameNumber(_arg_1, _arg_2));
            };
        }


    }
}
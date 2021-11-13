package com.sulake.habbo.room.object.visualization.furniture
{
    public class FurnitureScoreBoardVisualization extends AnimatedFurnitureVisualization 
    {

        private static const ONES_SPRITE_TAG:String = "ones_sprite";
        private static const TENS_SPRITE_TAG:String = "tens_sprite";
        private static const HUNDREDS_SPRITE_TAG:String = "hundreds_sprite";
        private static const THOUSANDS_SPRITE_TAG:String = "thousands_sprite";


        override public function get animationId():int
        {
            return (0);
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            var _local_4:int = super.animationId;
            switch (_local_3)
            {
                case "ones_sprite":
                    return (_local_4 % 10);
                case "tens_sprite":
                    return ((_local_4 / 10) % 10);
                case "hundreds_sprite":
                    return ((_local_4 / 100) % 10);
                case "thousands_sprite":
                    return ((_local_4 / 1000) % 10);
                default:
                    return (super.getFrameNumber(_arg_1, _arg_2));
            };
        }


    }
}
package com.sulake.habbo.room.object.visualization.furniture
{
    import com.sulake.room.object.IRoomObjectModel;

    public class FurnitureVoteCounterVisualization extends AnimatedFurnitureVisualization 
    {

        private static const ONES_SPRITE_TAG:String = "ones_sprite";
        private static const TENS_SPRITE_TAG:String = "tens_sprite";
        private static const HUNDREDS_SPRITE_TAG:String = "hundreds_sprite";
        private static const HIDE_COUNTER_SCORE:int = -1;


        override protected function updateObject(_arg_1:Number, _arg_2:Number):Boolean
        {
            super.updateObject(_arg_1, _arg_2);
            return (true);
        }

        override protected function getFrameNumber(_arg_1:int, _arg_2:int):int
        {
            var _local_4:IRoomObjectModel = object.getModel();
            var _local_5:int = _local_4.getNumber("furniture_vote_counter_count");
            var _local_3:String = getSpriteTag(_arg_1, direction, _arg_2);
            switch (_local_3)
            {
                case "ones_sprite":
                    return (_local_5 % 10);
                case "tens_sprite":
                    return ((_local_5 / 10) % 10);
                case "hundreds_sprite":
                    return ((_local_5 / 100) % 10);
                default:
                    return (super.getFrameNumber(_arg_1, _arg_2));
            };
        }

        override protected function getSpriteAlpha(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            var _local_4:String;
            var _local_5:IRoomObjectModel = object.getModel();
            var _local_6:int = _local_5.getNumber("furniture_vote_counter_count");
            if (_local_6 == -1)
            {
                _local_4 = getSpriteTag(_arg_1, _arg_2, _arg_3);
                switch (_local_4)
                {
                    case "ones_sprite":
                    case "tens_sprite":
                    case "hundreds_sprite":
                        return (0);
                };
            };
            return (super.getSpriteAlpha(_arg_1, _arg_2, _arg_3));
        }


    }
}
package com.sulake.habbo.freeflowchat.viewer.simulation
{
    public class ChatFlowGravity 
    {

        public static const INPUT_GRAVITY_COEFFICIENT:int = 60;
        public static const INPUT_GRAVITY_USERPOS_MARGIN:int = 15;
        public static const INPUT_GRAVITY_MAX_IMPULSE:Number = 40;

        private const MAX_ATTRACTION_RANGE:Number = 380;
        private const _SafeStr_2189:Number = 1;


        public function getAttraction(_arg_1:ChatBubbleSimulationEntity, _arg_2:ChatBubbleSimulationEntity, _arg_3:Number=1, _arg_4:Number=100):Number
        {
            var _local_5:Number = Math.abs((_arg_2.centerX - _arg_1.centerX));
            if (_local_5 > 380)
            {
                return (0);
            };
            if (_local_5 < 1)
            {
                return (0);
            };
            var _local_6:int = ((_arg_1.centerX <= _arg_2.centerX) ? 1 : -1);
            return (_local_6 * Math.min(Math.min(_local_5, (_arg_3 / _local_5)), _arg_4));
        }


    }
}


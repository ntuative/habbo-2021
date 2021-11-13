package com.sulake.habbo.freeflowchat.viewer.simulation
{
    import flash.geom.Rectangle;
    import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;

    public class ChatBubbleSimulationWithLimitedWideRect extends ChatBubbleSimulationEntity 
    {

        public static const WIDERECT_WIDTH:int = 240;

        private var _wideRectOffset:Number;

        public function ChatBubbleSimulationWithLimitedWideRect(_arg_1:PooledChatBubble)
        {
            super(_arg_1, false);
            _SafeStr_2184 = new Rectangle();
            _SafeStr_2184.width = 240;
            _SafeStr_2184.height = (_SafeStr_2183.height / 2);
            _wideRectOffset = (-(240 - _SafeStr_2183.width) / 2);
            _SafeStr_2184.x = (_SafeStr_2183.x + _wideRectOffset);
            _SafeStr_2184.y = _SafeStr_2183.y;
        }

        override public function set x(_arg_1:Number):void
        {
            _SafeStr_954 = (_SafeStr_954 + ((_arg_1 - _SafeStr_954) * (1 - 0.1)));
            _SafeStr_2183.x = _SafeStr_954;
            if (_SafeStr_2184)
            {
                _SafeStr_2184.x = (_SafeStr_2183.x + _wideRectOffset);
            };
        }

        override public function initializePosition(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Rectangle = _visualization.overlap;
            _SafeStr_954 = (_arg_1 + ((_local_3) ? _local_3.x : 0));
            _SafeStr_955 = (_arg_2 + ((_local_3) ? _local_3.y : 0));
            _SafeStr_2183.x = _SafeStr_954;
            _SafeStr_2183.y = _SafeStr_955;
            if (_SafeStr_2184)
            {
                _SafeStr_2184.x = (_SafeStr_2183.x + _wideRectOffset);
                _SafeStr_2184.y = _SafeStr_2183.y;
            };
        }

        public function get wideRectOffset():Number
        {
            return (_wideRectOffset);
        }

        public function set wideRectOffset(_arg_1:Number):void
        {
            _wideRectOffset = _arg_1;
        }


    }
}


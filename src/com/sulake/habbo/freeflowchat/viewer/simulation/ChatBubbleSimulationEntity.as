package com.sulake.habbo.freeflowchat.viewer.simulation
{
    import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
    import flash.geom.Rectangle;
    import __AS3__.vec.Vector;

    public class ChatBubbleSimulationEntity 
    {

        public static const VISUALIZATION_OVERLAP_VERTICAL:int = 10;

        protected const MOVE_NEGATIVE_FEEDBACK:Number = 0.1;
        private const _SafeStr_2187:int = 2500;

        protected var _visualization:PooledChatBubble;
        protected var _SafeStr_954:Number;
        protected var _SafeStr_955:Number;
        protected var _SafeStr_2183:Rectangle = new Rectangle();
        protected var _SafeStr_2184:Rectangle = null;
        protected var _SafeStr_2185:Number;
        protected var _SafeStr_2186:Number;
        private var _SafeStr_2188:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
        private var _isSpacer:Boolean = false;

        public function ChatBubbleSimulationEntity(_arg_1:PooledChatBubble, _arg_2:Boolean=false)
        {
            _visualization = _arg_1;
            var _local_3:Rectangle = _arg_1.overlap;
            _SafeStr_954 = (_arg_1.x + ((_local_3) ? _local_3.x : 0));
            _SafeStr_955 = (_arg_1.y + ((_local_3) ? _local_3.y : 0));
            _SafeStr_2183.x = _SafeStr_954;
            _SafeStr_2183.y = _SafeStr_955;
            _SafeStr_2183.width = (_visualization.width - ((_local_3) ? (_local_3.x + _local_3.width) : 0));
            _SafeStr_2183.height = ((_visualization.displayedHeight - 10) - ((_local_3) ? (_local_3.y + _local_3.height) : 0));
            if (_visualization.minHeight != -1)
            {
                _SafeStr_2183.height = _visualization.minHeight;
            };
            if (_arg_2)
            {
                _SafeStr_2184 = new Rectangle();
                _SafeStr_2184.width = (_SafeStr_2183.width + (2 * 2500));
                _SafeStr_2184.height = ((_visualization.minHeight != -1) ? _visualization.minHeight : (_SafeStr_2183.height / 2));
                _SafeStr_2184.x = (_SafeStr_2183.x - 2500);
                _SafeStr_2184.y = _SafeStr_2183.y;
            };
        }

        public function dispose():void
        {
            if (_visualization)
            {
                _visualization.readyToRecycle = true;
            };
            _visualization = null;
            _SafeStr_2183 = null;
            _SafeStr_2188 = null;
            _SafeStr_2184 = null;
        }

        public function get y():Number
        {
            return (_SafeStr_955);
        }

        public function set y(_arg_1:Number):void
        {
            _SafeStr_955 = _arg_1;
            _SafeStr_2183.y = _SafeStr_955;
            if (_SafeStr_2184)
            {
                _SafeStr_2184.y = _SafeStr_2183.y;
            };
        }

        public function get x():Number
        {
            return (_SafeStr_954);
        }

        public function set x(_arg_1:Number):void
        {
            _SafeStr_954 = (_SafeStr_954 + ((_arg_1 - _SafeStr_954) * (1 - 0.1)));
            _SafeStr_2183.x = _SafeStr_954;
            if (_SafeStr_2184)
            {
                _SafeStr_2184.x = (_SafeStr_2183.x - 2500);
            };
        }

        public function get visualRect():Rectangle
        {
            return (_SafeStr_2183);
        }

        public function get wideRect():Rectangle
        {
            return ((_SafeStr_2184) ? _SafeStr_2184 : _SafeStr_2183);
        }

        public function get hasWideRect():Boolean
        {
            return (!(_SafeStr_2184 == null));
        }

        public function get centerX():Number
        {
            return (_SafeStr_954 + (_SafeStr_2183.width / 2));
        }

        public function initializePosition(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Rectangle = _visualization.overlap;
            _SafeStr_954 = (_arg_1 + ((_local_3) ? _local_3.x : 0));
            _SafeStr_955 = (_arg_2 + ((_local_3) ? _local_3.y : 0));
            _SafeStr_2183.x = _SafeStr_954;
            _SafeStr_2183.y = _SafeStr_955;
            if (_SafeStr_2184)
            {
                _SafeStr_2184.x = (_SafeStr_2183.x - 2500);
                _SafeStr_2184.y = _SafeStr_2183.y;
            };
        }

        public function addHorizontalImpulse(_arg_1:Number):void
        {
            _SafeStr_2185 = (_SafeStr_2185 + _arg_1);
        }

        public function addCollisionHandled(_arg_1:ChatBubbleSimulationEntity):void
        {
            _SafeStr_2188.push(_arg_1);
        }

        public function hasCollidedWith(_arg_1:ChatBubbleSimulationEntity):Boolean
        {
            return (!(_SafeStr_2188.indexOf(_arg_1) == -1));
        }

        public function addVerticalImpulse(_arg_1:Number):void
        {
            _SafeStr_2186 = (_SafeStr_2186 + _arg_1);
        }

        public function applyImpulseForces(_arg_1:int):void
        {
            x = (x + _SafeStr_2185);
            y = (y + Math.max(_SafeStr_2186, -(_arg_1)));
        }

        public function resetSimulationStep():void
        {
            _SafeStr_2185 = 0;
            _SafeStr_2186 = 0;
            _SafeStr_2188 = new Vector.<ChatBubbleSimulationEntity>(0);
        }

        public function syncToVisualization(_arg_1:Boolean=false):void
        {
            var _local_2:Rectangle = _visualization.overlap;
            if (!_arg_1)
            {
                _visualization.moveTo((_SafeStr_954 - ((_local_2) ? _local_2.x : 0)), (_SafeStr_955 - ((_local_2) ? _local_2.y : 0)));
            }
            else
            {
                _visualization.warpTo((_SafeStr_954 - ((_local_2) ? _local_2.x : 0)), (_SafeStr_955 - ((_local_2) ? _local_2.y : 0)));
            };
        }

        public function set fullHeightCollision(_arg_1:Boolean):void
        {
            if (_SafeStr_2184)
            {
                _SafeStr_2184.height = ((_arg_1) ? _SafeStr_2183.height : (_SafeStr_2183.height / 2));
            };
        }

        public function get visualizationHasHitMargin():Boolean
        {
            return (_visualization.hasHitDesktopMargin);
        }

        public function set readyToRecycle(_arg_1:Boolean):void
        {
            _visualization.readyToRecycle = _arg_1;
        }

        public function get readyToRecycle():Boolean
        {
            return (_visualization.readyToRecycle);
        }

        public function get timeStamp():uint
        {
            return (_visualization.timeStamp);
        }

        public function get isSpacer():Boolean
        {
            return (_isSpacer);
        }

        public function set isSpacer(_arg_1:Boolean):void
        {
            _isSpacer = _arg_1;
        }

        public function intersectsWith(_arg_1:ChatBubbleSimulationEntity):Boolean
        {
            if (_SafeStr_2184)
            {
                return ((_SafeStr_2183.intersects(_arg_1._SafeStr_2183)) || (_SafeStr_2184.intersects(_arg_1.wideRect)));
            };
            if (_arg_1._SafeStr_2184)
            {
                return ((_SafeStr_2183.intersects(_arg_1._SafeStr_2183)) || (_SafeStr_2183.intersects(_arg_1._SafeStr_2184)));
            };
            return (_SafeStr_2183.intersects(_arg_1._SafeStr_2183));
        }

        public function visualIntertersectsWith(_arg_1:ChatBubbleSimulationEntity):Boolean
        {
            return (_SafeStr_2183.intersects(_arg_1._SafeStr_2183));
        }


    }
}


package com.sulake.habbo.room.object.visualization.avatar.additions
{
    import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
    import com.sulake.room.object.visualization.IRoomObjectSprite;

    public class ExpressionAddition implements IExpressionAddition 
    {

        protected var _SafeStr_698:int;
        protected var _SafeStr_1265:AvatarVisualization;
        private var _type:int = -1;

        public function ExpressionAddition(_arg_1:int, _arg_2:int, _arg_3:AvatarVisualization)
        {
            _type = _arg_2;
            _SafeStr_698 = _arg_1;
            _SafeStr_1265 = _arg_3;
        }

        public function get type():int
        {
            return (_type);
        }

        public function get id():int
        {
            return (_SafeStr_698);
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_1265 == null);
        }

        public function dispose():void
        {
            _SafeStr_1265 = null;
        }

        public function update(_arg_1:IRoomObjectSprite, _arg_2:Number):void
        {
        }

        public function animate(_arg_1:IRoomObjectSprite):Boolean
        {
            return (false);
        }


    }
}


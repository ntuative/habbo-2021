package com.sulake.core.window.services
{
    import flash.display.DisplayObject;

    public class WindowMouseScaler extends WindowMouseOperator implements IMouseScalingService 
    {

        public function WindowMouseScaler(_arg_1:DisplayObject)
        {
            super(_arg_1);
        }

        override public function operate(_arg_1:int, _arg_2:int):void
        {
            var _local_3:int;
            if (!_window.disposed)
            {
                _local_3 = ((_SafeStr_852 & 0x1000) ? (_arg_1 - _mouse.x) : 0);
                var _local_4:int = ((_SafeStr_852 & 0x2000) ? (_arg_2 - _mouse.y) : 0);
                _window.scale(_local_3, _local_4);
            };
        }


    }
}


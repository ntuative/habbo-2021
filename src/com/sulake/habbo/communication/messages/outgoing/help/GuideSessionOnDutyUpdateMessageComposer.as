package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class GuideSessionOnDutyUpdateMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_690:Array = [];
        private var _disposed:Boolean = false;

        public function GuideSessionOnDutyUpdateMessageComposer(_arg_1:Boolean, _arg_2:Boolean, _arg_3:Boolean, _arg_4:Boolean)
        {
            _SafeStr_690 = [_arg_1, _arg_2, _arg_3, _arg_4];
        }

        public function getMessageArray():Array
        {
            return (_SafeStr_690);
        }

        public function dispose():void
        {
            _SafeStr_690 = null;
            _disposed = true;
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }


    }
}


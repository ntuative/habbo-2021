package com.sulake.habbo.communication.messages.outgoing.help
{
    import com.sulake.core.communication.messages.IMessageComposer;
    import com.sulake.core.runtime.IDisposable;

        public class GuideSessionGuideDecidesMessageComposer implements IMessageComposer, IDisposable 
    {

        private var _SafeStr_690:Array = [];
        private var _disposed:Boolean = false;

        public function GuideSessionGuideDecidesMessageComposer(_arg_1:Boolean)
        {
            _SafeStr_690.push(_arg_1);
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


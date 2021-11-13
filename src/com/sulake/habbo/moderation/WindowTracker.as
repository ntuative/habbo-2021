package com.sulake.habbo.moderation
{
    import flash.utils.Dictionary;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.components.IFrameWindow;

    public class WindowTracker 
    {

        public static const TYPE_USERINFO:int = 1;
        public static const _SafeStr_2885:int = 2;
        public static const _SafeStr_2886:int = 3;
        public static const _SafeStr_2887:int = 4;
        public static const _SafeStr_2888:int = 5;
        public static const _SafeStr_2889:int = 6;
        public static const _SafeStr_2890:int = 7;
        public static const TYPE_ISSUEHANDLER:int = 8;
        public static const TYPE_ROOMINFO:int = 9;

        private var _SafeStr_2891:Dictionary = new Dictionary();


        public function show(_arg_1:ITrackedWindow, _arg_2:IFrameWindow, _arg_3:Boolean, _arg_4:Boolean, _arg_5:Boolean, _arg_6:Boolean=false, _arg_7:int=0, _arg_8:int=0, _arg_9:int=0, _arg_10:int=0):void
        {
            var _local_14:IWindow;
            var _local_13:int;
            var _local_11:IWindow;
            var _local_12:ITrackedWindow = this.removeWindow(_arg_1.getType(), _arg_1.getId());
            if (((!(_local_12 == null)) && (!(_local_12.disposed))))
            {
                if (_arg_5)
                {
                    _arg_1.dispose();
                    _local_12.dispose();
                    return;
                };
                _arg_1.show();
                _local_14 = _local_12.getFrame();
                _arg_1.getFrame().x = ((_arg_6) ? _arg_7 : _local_14.x);
                _arg_1.getFrame().y = ((_arg_6) ? _arg_8 : _local_14.y);
                _arg_1.getFrame().width = ((_arg_6) ? _arg_9 : _local_14.width);
                _arg_1.getFrame().height = ((_arg_6) ? _arg_10 : _local_14.height);
                this.getWindowsForType(_arg_1.getType())[_arg_1.getId()] = _arg_1;
                _local_12.dispose();
            }
            else
            {
                if (!_arg_4)
                {
                    _arg_1.show();
                    if (_arg_2 != null)
                    {
                        _local_13 = 5;
                        if (_arg_3)
                        {
                            _arg_1.getFrame().x = ((_arg_6) ? _arg_7 : _arg_2.x);
                            _arg_1.getFrame().y = ((_arg_6) ? _arg_8 : ((_arg_2.y + _arg_2.height) + _local_13));
                        }
                        else
                        {
                            _arg_1.getFrame().x = ((_arg_6) ? _arg_7 : ((_arg_2.x + _arg_2.width) + _local_13));
                            _arg_1.getFrame().y = ((_arg_6) ? _arg_8 : _arg_2.y);
                        };
                    }
                    else
                    {
                        if (_arg_6)
                        {
                            _arg_1.getFrame().x = _arg_7;
                            _arg_1.getFrame().y = _arg_8;
                        }
                        else
                        {
                            _local_11 = _arg_1.getFrame().desktop;
                            _arg_1.getFrame().x = ((_local_11.width / 2) - (_arg_1.getFrame().width / 2));
                            _arg_1.getFrame().y = ((_local_11.height / 2) - (_arg_1.getFrame().height / 2));
                        };
                    };
                    _arg_1.getFrame().x = Math.max(0, Math.min(_arg_1.getFrame().x, (_arg_1.getFrame().desktop.width - _arg_1.getFrame().width)));
                    _arg_1.getFrame().y = Math.max(0, Math.min(_arg_1.getFrame().y, (_arg_1.getFrame().desktop.height - _arg_1.getFrame().height)));
                    this.getWindowsForType(_arg_1.getType())[_arg_1.getId()] = _arg_1;
                };
            };
        }

        private function removeWindow(_arg_1:int, _arg_2:String):ITrackedWindow
        {
            var _local_4:Dictionary = this.getWindowsForType(_arg_1);
            var _local_3:ITrackedWindow = _local_4[_arg_2];
            _local_4[_arg_2] = null;
            return (_local_3);
        }

        private function getWindowsForType(_arg_1:int):Dictionary
        {
            var _local_2:Dictionary = _SafeStr_2891[_arg_1];
            if (_local_2 == null)
            {
                _local_2 = new Dictionary();
                _SafeStr_2891[_arg_1] = _local_2;
            };
            return (_local_2);
        }


    }
}


package com.sulake.habbo.quest
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import flash.geom.Point;
    import com.sulake.core.window.IWindow;

    public class ProgressBar implements IDisposable 
    {

        private static const PROGRESS_TEXT_X_OFFSET:int = 3;
        private static const CONTAINER_SPACING:int = 10;

        private var _questEngine:HabboQuestEngine;
        private var _window:IWindowContainer;
        private var _progressBarWidth:int;
        private var _progressKey:String;
        private var _hasFrame:Boolean;
        private var _currentAmount:int;
        private var _maxAmount:int;
        private var _SafeStr_3126:int;
        private var _SafeStr_3127:int;
        private var _startProgressWidth:int;
        private var _currentProgressWidth:int;
        private var _SafeStr_3128:Boolean;

        public function ProgressBar(_arg_1:HabboQuestEngine, _arg_2:IWindowContainer, _arg_3:int, _arg_4:String, _arg_5:Boolean, _arg_6:Point)
        {
            _questEngine = _arg_1;
            _window = _arg_2;
            _progressBarWidth = _arg_3;
            _progressKey = _arg_4;
            _hasFrame = _arg_5;
            var _local_7:IWindowContainer = IWindowContainer(_window.findChildByName("progress_bar_cont"));
            if (_local_7 == null)
            {
                _local_7 = IWindowContainer(_questEngine.getXmlWindow("ProgressBar"));
                _window.addChild(_local_7);
                _local_7.x = _arg_6.x;
                _local_7.y = _arg_6.y;
                _local_7.width = (_progressBarWidth + 10);
            };
        }

        public function refresh(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
            var _local_5:Boolean = ((!(_arg_3 == _SafeStr_3127)) || (!(_arg_2 == _maxAmount)));
            _maxAmount = _arg_2;
            _currentAmount = _arg_1;
            _startProgressWidth = _currentProgressWidth;
            _SafeStr_3127 = _arg_3;
            _SafeStr_3126 = _arg_4;
            if (((_local_5) || ((_currentAmount == 0) && (_currentProgressWidth > 0))))
            {
                _currentProgressWidth = getProgressWidth(_currentAmount);
            };
            _SafeStr_3128 = true;
            updateView();
        }

        public function set visible(_arg_1:Boolean):void
        {
            var _local_2:IWindowContainer = IWindowContainer(_window.findChildByName("progress_bar_cont"));
            if (_local_2 != null)
            {
                _local_2.visible = _arg_1;
            };
        }

        public function updateView():void
        {
            var _local_10:int;
            if (!_SafeStr_3128)
            {
                return;
            };
            var _local_5:IWindow = _window.findChildByName("bar_a_bkg");
            var _local_8:IWindow = _window.findChildByName("bar_a_c");
            var _local_7:IWindow = _window.findChildByName("bar_a_r");
            var _local_9:IWindow = _window.findChildByName("bar_l");
            var _local_3:IWindow = _window.findChildByName("bar_c");
            var _local_6:IWindow = _window.findChildByName("bar_r");
            _local_9.visible = _hasFrame;
            _local_3.visible = _hasFrame;
            _local_6.visible = _hasFrame;
            if (_hasFrame)
            {
                _local_3.width = _progressBarWidth;
                _local_6.x = (_progressBarWidth + _local_8.x);
            };
            var _local_1:int = getProgressWidth(_currentAmount);
            if (_currentProgressWidth < _local_1)
            {
                _local_10 = Math.min(Math.abs((_currentProgressWidth - _local_1)), Math.abs((_startProgressWidth - _local_1)));
                _currentProgressWidth = Math.min(_local_1, (_currentProgressWidth + Math.max(1, Math.round(Math.sqrt(_local_10)))));
            };
            var _local_11:Boolean = (_currentProgressWidth > 0);
            _local_5.visible = _local_11;
            _local_8.visible = _local_11;
            _local_7.visible = _local_11;
            if (_local_11)
            {
                _local_8.blend = (1 - ((_local_1 - _currentProgressWidth) / (_local_1 - _startProgressWidth)));
                _local_8.width = _currentProgressWidth;
                _local_7.x = (_currentProgressWidth + _local_8.x);
                _local_5.width = (_local_7.right - _local_8.left);
            };
            _SafeStr_3128 = (_currentProgressWidth < _local_1);
            var _local_4:IWindow = _window.findChildByName("progress_txt");
            var _local_2:int = ((_SafeStr_3128) ? Math.round(((_currentProgressWidth / _progressBarWidth) * _maxAmount)) : _currentAmount);
            _questEngine.localization.registerParameter(_progressKey, "progress", ("" + (_local_2 + _SafeStr_3126)));
            _questEngine.localization.registerParameter(_progressKey, "limit", ("" + (_maxAmount + _SafeStr_3126)));
            _local_4.caption = _questEngine.localization.getLocalization(_progressKey, _progressKey);
            _local_4.x = ((3 + _local_8.x) + ((_progressBarWidth - _local_4.width) / 2));
        }

        public function dispose():void
        {
            _questEngine = null;
            _window = null;
        }

        public function get disposed():Boolean
        {
            return (_questEngine == null);
        }

        private function getProgressWidth(_arg_1:int):int
        {
            return (Math.max(0, Math.round(((_progressBarWidth * _arg_1) / _maxAmount))));
        }


    }
}


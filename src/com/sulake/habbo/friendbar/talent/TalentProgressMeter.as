package com.sulake.habbo.friendbar.talent
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrack;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
    import com.sulake.core.window.components.IWidgetWindow;
    import com.sulake.habbo.utils._SafeStr_25;
    import com.sulake.habbo.window.widgets.IAvatarImageWidget;
    import com.sulake.core.window.IWindow;

    public class TalentProgressMeter implements IDisposable 
    {

        private const ACHIEVED_DIVIDER:String = "talent_achieved_div";
        private const UNACHIEVED_DIVIDER:String = "talent_unachieved_div";
        private const DIVIDER_WINDOW_PREFIX:String = "progress_divider_level_";
        private const AVATAR_GLOW_RADIUS:int = 10;

        private var _disposed:Boolean = false;
        private var _habboTalent:HabboTalent;
        private var _SafeStr_1284:TalentTrackController;
        private var _talentTrack:TalentTrack;
        private var _SafeStr_2387:IWindowContainer;
        private var _divider:IStaticBitmapWrapperWindow;
        private var _SafeStr_2388:IWidgetWindow;
        private var _SafeStr_2389:IStaticBitmapWrapperWindow;
        private var _SafeStr_2390:IStaticBitmapWrapperWindow;

        public function TalentProgressMeter(_arg_1:HabboTalent, _arg_2:TalentTrackController)
        {
            _habboTalent = _arg_1;
            _SafeStr_1284 = _arg_2;
            _talentTrack = _SafeStr_1284.talentTrack;
            createMeter();
        }

        public function get width():int
        {
            return (_SafeStr_1284.window.width);
        }

        public function get progressPerLevelWidth():int
        {
            return (Math.floor(_SafeStr_25.lerp(_talentTrack.progressPerLevel, 0, width)));
        }

        private function createMeter():void
        {
            var _local_2:int;
            var _local_1:IStaticBitmapWrapperWindow;
            _SafeStr_2387 = IWindowContainer(_SafeStr_1284.window.findChildByName("progress_container"));
            _divider = IStaticBitmapWrapperWindow(_SafeStr_2387.removeChild(_SafeStr_2387.findChildByName("progress_level_divider")));
            _SafeStr_2389 = IStaticBitmapWrapperWindow(_SafeStr_2387.findChildByName("achieved_mid"));
            _SafeStr_2390 = IStaticBitmapWrapperWindow(_SafeStr_2387.findChildByName("unachieved_mid"));
            _local_2 = 1;
            while (_local_2 < _talentTrack.levels.length)
            {
                _local_1 = IStaticBitmapWrapperWindow(_divider.clone());
                _local_1.name = ("progress_divider_level_" + _local_2);
                _SafeStr_2387.addChild(_local_1);
                _local_2++;
            };
            _SafeStr_2388 = IWidgetWindow(_SafeStr_2387.findChildByName("progress_needle"));
            IAvatarImageWidget(_SafeStr_2388.widget).figure = _habboTalent.sessionManager.figure;
            _SafeStr_2387.setChildIndex(_SafeStr_2388, (_SafeStr_2387.numChildren - 1));
        }

        public function dispose():void
        {
            if (!_disposed)
            {
                if (_divider)
                {
                    _divider.dispose();
                    _divider = null;
                };
                _SafeStr_2389 = null;
                _SafeStr_2390 = null;
                _SafeStr_2388 = null;
                _SafeStr_2387 = null;
                _talentTrack = null;
                _SafeStr_1284 = null;
                _habboTalent = null;
                _disposed = true;
            };
        }

        public function get disposed():Boolean
        {
            return (_disposed);
        }

        public function resize():void
        {
            var _local_5:int;
            var _local_4:IStaticBitmapWrapperWindow;
            var _local_1:int = Math.floor(_SafeStr_25.lerp(_talentTrack.totalProgress, 0, width));
            _SafeStr_2387.width = width;
            _SafeStr_2390.width = width;
            _SafeStr_2389.width = _local_1;
            _SafeStr_2388.x = _SafeStr_25.clamp((_local_1 - int((_SafeStr_2388.width / 2))), 0, (width - _SafeStr_2388.width));
            var _local_2:IWindow = _SafeStr_2387.findChildByName("avatar_glow");
            _local_2.x = (_SafeStr_2388.x - 10);
            _local_2.y = (_SafeStr_2388.y - 10);
            _local_2.width = (_SafeStr_2388.width + (2 * 10));
            _local_2.height = (_SafeStr_2388.height + (2 * 10));
            var _local_3:IWindow = _SafeStr_2387.findChildByName("progress_balloon");
            _local_3.x = (((_SafeStr_2388.x + Math.floor((_SafeStr_2388.width / 2))) - Math.floor((_local_3.width / 2))) + 5);
            _local_5 = 1;
            while (_local_5 < _talentTrack.levels.length)
            {
                _local_4 = IStaticBitmapWrapperWindow(_SafeStr_2387.findChildByName(("progress_divider_level_" + _local_5)));
                _local_4.x = (_local_5 * progressPerLevelWidth);
                if (_local_4.x < _local_1)
                {
                    _local_4.assetUri = "talent_achieved_div";
                }
                else
                {
                    _local_4.assetUri = "talent_unachieved_div";
                };
                _local_4.visible = true;
                _local_5++;
            };
            _SafeStr_2387.invalidate();
        }


    }
}


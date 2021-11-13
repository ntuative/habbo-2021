package com.sulake.habbo.friendbar.talent
{
    import com.sulake.core.runtime.IDisposable;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageEvent;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackLevelMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserObjectEvent;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackLevelMessageComposer;
    import com.sulake.habbo.communication.messages.parser.talent.TalentTrackLevelMessageParser;
    import com.sulake.habbo.communication.messages.parser.talent.TalentLevelUpMessageParser;
    import com.sulake.habbo.communication.messages.outgoing.talent.GetTalentTrackMessageComposer;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowMouseEvent;

    public class TalentPromoCtrl implements IDisposable 
    {

        private static const BG_COLOR_LIGHT:uint = 4286084205;
        private static const BG_COLOR_DARK:uint = 4283781966;

        private var _SafeStr_825:HabboTalent;
        private var _window:IWindowContainer;
        private var _SafeStr_346:int;
        private var _SafeStr_2391:int;
        private var _SafeStr_2392:int;

        public function TalentPromoCtrl(_arg_1:HabboTalent)
        {
            _SafeStr_825 = _arg_1;
        }

        public function dispose():void
        {
            if (toolbarAttachAllowed())
            {
                _SafeStr_825.toolbar.extensionView.detachExtension("talent_promo");
            };
            _SafeStr_825 = null;
            if (_window)
            {
                _window.dispose();
                _window = null;
            };
        }

        public function get disposed():Boolean
        {
            return (_SafeStr_825 == null);
        }

        public function initialize():void
        {
            if (!enabled)
            {
                return;
            };
            _SafeStr_825.communicationManager.addHabboConnectionMessageEvent(new TalentLevelUpMessageEvent(onTalentLevelUp));
            _SafeStr_825.communicationManager.addHabboConnectionMessageEvent(new TalentTrackLevelMessageEvent(onTalentTrackLevel));
            _SafeStr_825.communicationManager.addHabboConnectionMessageEvent(new UserObjectEvent(onUserObject));
        }

        private function onUserObject(_arg_1:UserObjectEvent):void
        {
            _SafeStr_825.send(new GetTalentTrackLevelMessageComposer(promotedTalentTrack));
        }

        private function onTalentTrackLevel(_arg_1:TalentTrackLevelMessageEvent):void
        {
            var _local_2:TalentTrackLevelMessageParser = _arg_1.getParser();
            if (_local_2.talentTrackName == promotedTalentTrack)
            {
                _SafeStr_2391 = _local_2.maxLevel;
                _SafeStr_346 = _local_2.level;
                refresh();
            };
        }

        private function onTalentLevelUp(_arg_1:TalentLevelUpMessageEvent):void
        {
            var _local_2:TalentLevelUpMessageParser = _arg_1.getParser();
            if (_local_2.talentTrackName == promotedTalentTrack)
            {
                _SafeStr_346 = _local_2.level;
                refresh();
            };
        }

        private function refresh():void
        {
            if (((!(enabled)) || (maxLevelReached)))
            {
                close();
                return;
            };
            prepareWindow();
            setText("title");
            _window.x = 0;
            _window.y = 0;
            if (toolbarAttachAllowed())
            {
                _SafeStr_825.toolbar.extensionView.attachExtension("talent_promo", _window, 7);
            };
        }

        private function setText(_arg_1:String):void
        {
            _window.findChildByName((_arg_1 + "_txt")).caption = (((("${talentpromo." + promotedTalentTrack) + ".") + _arg_1) + "}");
        }

        private function prepareWindow():void
        {
            if (this._window != null)
            {
                return;
            };
            _window = IWindowContainer(_SafeStr_825.getXmlWindow("track_promo"));
            _window.addEventListener("WME_CLICK", onCheckProgress);
            _window.addEventListener("WME_OVER", onContainerMouseOver);
            _window.addEventListener("WME_OUT", onContainerMouseOut);
            _SafeStr_2392 = _window.height;
        }

        public function close():void
        {
            if (_window != null)
            {
                if (toolbarAttachAllowed())
                {
                    _SafeStr_825.toolbar.extensionView.detachExtension("talent_promo");
                };
            };
        }

        private function onCheckProgress(_arg_1:WindowEvent, _arg_2:IWindow=null):void
        {
            if (((_arg_1.type == "WME_CLICK") && (enabled)))
            {
                _SafeStr_825.tracking.trackTalentTrackOpen(promotedTalentTrack, "talentpromo");
                _SafeStr_825.send(new GetTalentTrackMessageComposer(promotedTalentTrack));
            };
        }

        private function toolbarAttachAllowed():Boolean
        {
            return ((((!(_SafeStr_825 == null)) && (!(_SafeStr_825.toolbar == null))) && (!(_SafeStr_825.toolbar.extensionView == null))) && (enabled));
        }

        private function get enabled():Boolean
        {
            return (!(promotedTalentTrack == ""));
        }

        private function get promotedTalentTrack():String
        {
            return (_SafeStr_825.getProperty("talentpromo.track"));
        }

        private function get maxLevelReached():Boolean
        {
            return (_SafeStr_346 >= _SafeStr_2391);
        }

        private function onContainerMouseOver(_arg_1:WindowMouseEvent):void
        {
            _window.findChildByTag("BGCOLOR").color = 4286084205;
        }

        private function onContainerMouseOut(_arg_1:WindowMouseEvent):void
        {
            _window.findChildByTag("BGCOLOR").color = 4283781966;
        }


    }
}


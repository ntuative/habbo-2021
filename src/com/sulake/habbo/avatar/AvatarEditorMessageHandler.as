package com.sulake.habbo.avatar
{
    import com.sulake.habbo.communication.IHabboCommunicationManager;
    import com.sulake.habbo.communication.messages.parser.room.action.AvatarEffectMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectSelectedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.handshake.UserRightsMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.CheckUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.avatar.WardrobeMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectExpiredMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectAddedMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.AvatarEffectActivatedMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.SaveWardrobeOutfitMessageComposer;
    import com.sulake.habbo.communication.messages.outgoing.avatar.CheckUserNameMessageComposer;
    import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
    import com.sulake.habbo.communication.messages.parser.avatar.CheckUserNameResultMessageParser;
    import com.sulake.habbo.communication.messages.incoming.avatar.ChangeUserNameResultMessageEvent;
    import com.sulake.habbo.communication.messages.outgoing.avatar.GetWardrobeMessageComposer;
    import com.sulake.core.communication.messages.IMessageEvent;

    public class AvatarEditorMessageHandler 
    {

        private var _communication:IHabboCommunicationManager;
        private var _SafeStr_1284:HabboAvatarEditorManager;

        public function AvatarEditorMessageHandler(_arg_1:HabboAvatarEditorManager, _arg_2:IHabboCommunicationManager)
        {
            _SafeStr_1284 = _arg_1;
            _communication = _arg_2;
            _communication.addHabboConnectionMessageEvent(new AvatarEffectMessageEvent(onRoomAvatarEffects));
            _communication.addHabboConnectionMessageEvent(new AvatarEffectSelectedMessageEvent(onAvatarEffectSelected));
            _communication.addHabboConnectionMessageEvent(new UserRightsMessageEvent(onUserRights));
            _communication.addHabboConnectionMessageEvent(new CheckUserNameResultMessageEvent(onCheckUserNameResult));
            _communication.addHabboConnectionMessageEvent(new WardrobeMessageEvent(onWardrobe));
            _communication.addHabboConnectionMessageEvent(new AvatarEffectExpiredMessageEvent(onAvatarEffectExpired));
            _communication.addHabboConnectionMessageEvent(new AvatarEffectAddedMessageEvent(onAvatarEffectAdded));
            _communication.addHabboConnectionMessageEvent(new AvatarEffectActivatedMessageEvent(onAvatarEffectActivated));
        }

        public function dispose():void
        {
            _communication = null;
            _SafeStr_1284 = null;
        }

        public function saveWardrobeOutfit(_arg_1:int, _arg_2:IOutfit):void
        {
            if (_communication == null)
            {
                return;
            };
            var _local_3:SaveWardrobeOutfitMessageComposer = new SaveWardrobeOutfitMessageComposer(_arg_1, _arg_2.figure, _arg_2.gender);
            _communication.connection.send(_local_3);
            _local_3.dispose();
            _local_3 = null;
        }

        public function checkName(_arg_1:String):void
        {
            if (_communication == null)
            {
                return;
            };
            _communication.connection.send(new CheckUserNameMessageComposer(_arg_1));
        }

        private function onCheckUserNameResult(_arg_1:CheckUserNameResultMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_3:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_3 == null)
            {
                return;
            };
            var _local_2:AvatarEditorNameChangeView = _local_3.view.avatarEditorNameChangeView;
            if (_local_2 == null)
            {
                return;
            };
            var _local_4:CheckUserNameResultMessageParser = _arg_1.getParser();
            if (_local_4.resultCode == ChangeUserNameResultMessageEvent._SafeStr_505)
            {
                _local_2.checkedName = _local_4.name;
            }
            else
            {
                _local_2.setNameNotAvailableView(_local_4.resultCode, _local_4.name, _local_4.nameSuggestions);
            };
        }

        public function getWardrobe():void
        {
            if (_communication == null)
            {
                return;
            };
            var _local_1:GetWardrobeMessageComposer = new GetWardrobeMessageComposer();
            _communication.connection.send(_local_1);
            _local_1.dispose();
            _local_1 = null;
        }

        private function onWardrobe(_arg_1:WardrobeMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_2)
            {
                _local_2.wardrobe.updateSlots(_arg_1.state, _arg_1.outfits);
            };
        }

        private function onUserRights(_arg_1:UserRightsMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_2)
            {
                _local_2.clubMemberLevel = ((_arg_1.clubLevel != 0) ? 2 : 0);
                _local_2.update();
            };
        }

        private function onAvatarEffectAdded(_arg_1:IMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_2)
            {
                _local_2.effects.reset();
            };
        }

        private function onAvatarEffectActivated(_arg_1:AvatarEffectActivatedMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_2)
            {
                _local_2.effects.reset();
                _local_2.figureData.avatarEffectType = _arg_1.getParser().type;
                _local_2.figureData.updateView();
            };
        }

        private function onAvatarEffectExpired(_arg_1:AvatarEffectExpiredMessageEvent):void
        {
            var _local_3:int;
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_2)
            {
                _local_2.effects.reset();
                _local_3 = _arg_1.getParser().type;
                if (_local_2.figureData.avatarEffectType == _local_3)
                {
                    _local_2.figureData.avatarEffectType = -1;
                    _local_2.figureData.updateView();
                };
            };
        }

        private function onRoomAvatarEffects(_arg_1:AvatarEffectMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if ((((_local_2) && (!(_SafeStr_1284.roomDesktop == null))) && (_arg_1.getParser().userId == _SafeStr_1284.roomDesktop.roomSession.ownUserRoomId)))
            {
                _local_2.figureData.avatarEffectType = _arg_1.getParser().effectId;
                _local_2.figureData.updateView();
            };
        }

        private function onAvatarEffectSelected(_arg_1:AvatarEffectExpiredMessageEvent):void
        {
            if (((_arg_1 == null) || (!(_SafeStr_1284))))
            {
                return;
            };
            var _local_2:HabboAvatarEditor = _SafeStr_1284.getEditor(0);
            if (_local_2)
            {
                _local_2.figureData.avatarEffectType = _arg_1.getParser().type;
                _local_2.figureData.updateView();
            };
        }


    }
}


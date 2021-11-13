package com.sulake.habbo.catalog.viewer.widgets
{
    import com.sulake.habbo.sound.IHabboSoundManager;
    import com.sulake.core.communication.connection.IConnection;
    import com.sulake.core.window.IWindowContainer;
    import com.sulake.core.window.components._SafeStr_101;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.incoming.sound.OfficialSongIdMessageEvent;
    import com.sulake.habbo.catalog.HabboCatalog;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.habbo.sound.ISongInfo;
    import com.sulake.habbo.catalog.viewer.IProduct;
    import com.sulake.habbo.communication.messages.outgoing.sound.GetOfficialSongIdMessageComposer;
    import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
    import com.sulake.habbo.localization.IHabboLocalizationManager;
    import com.sulake.habbo.sound.events.SongInfoReceivedEvent;

    public class SongDiskProductViewCatalogWidget extends ProductViewCatalogWidget 
    {

        private var _soundManager:IHabboSoundManager;
        private var _connection:IConnection;
        private var _playPreviewContainer:IWindowContainer;
        private var _playButton:_SafeStr_101;
        private var _SafeStr_1617:IWindow;
        private var _SafeStr_1618:int = -1;
        private var _officialSongId:String = "";
        private var _timeLocalization:String = "";
        private var _officialSongIdListener:IMessageEvent = null;

        public function SongDiskProductViewCatalogWidget(_arg_1:IWindowContainer, _arg_2:HabboCatalog)
        {
            super(_arg_1, _arg_2);
            _playButton = (_window.findChildByName("listen") as _SafeStr_101);
            _SafeStr_1617 = _window.findChildByName("ctlg_song_length");
            if (_playButton != null)
            {
                _playButton.addEventListener("WME_CLICK", onClickPlay);
                _playButton.disable();
            };
            _playPreviewContainer = (_window.findChildByName("playPreviewContainer") as IWindowContainer);
            if (_playPreviewContainer != null)
            {
                _playPreviewContainer.visible = false;
            };
            _soundManager = _arg_2.soundManager;
            if (_soundManager != null)
            {
                _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
            };
            _connection = _arg_2.connection;
            if (((_connection) && (!(_officialSongIdListener))))
            {
                _officialSongIdListener = new OfficialSongIdMessageEvent(onOfficialSongIdMessageEvent);
                _connection.addMessageEvent(_officialSongIdListener);
            };
        }

        override public function dispose():void
        {
            if (_playButton != null)
            {
                _playButton.removeEventListener("WME_CLICK", onClickPlay);
            };
            if (((!(_soundManager == null)) && (!(_soundManager.musicController == null))))
            {
                _soundManager.musicController.stop(3);
                if (_soundManager.events != null)
                {
                    _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED", onSongInfoReceivedEvent);
                };
                _soundManager = null;
                if (((_connection) && (_officialSongIdListener)))
                {
                    _connection.removeMessageEvent(_officialSongIdListener);
                    _officialSongIdListener = null;
                };
                _connection = null;
            };
            super.dispose();
        }

        override public function closed():void
        {
            super.closed();
            if (((!(_soundManager == null)) && (!(_soundManager.musicController == null))))
            {
                _soundManager.musicController.stop(3);
            };
        }

        override public function init():Boolean
        {
            if (!super.init())
            {
                return (false);
            };
            if (page.offers.length == 0)
            {
                return (false);
            };
            events.addEventListener("SELECT_PRODUCT", onSelectProduct);
            return (true);
        }

        private function onClickPlay(_arg_1:WindowMouseEvent):void
        {
            if (((!(_soundManager == null)) && (!(_soundManager.musicController == null))))
            {
                forceNoFadeoutOnPlayingSong(0);
                forceNoFadeoutOnPlayingSong(3);
                _soundManager.musicController.playSong(_SafeStr_1618, 3, 15, 40, 0.5, 2);
            };
        }

        private function forceNoFadeoutOnPlayingSong(_arg_1:int):void
        {
            var _local_2:ISongInfo;
            var _local_3:int = _soundManager.musicController.getSongIdPlayingAtPriority(_arg_1);
            if (_local_3 != -1)
            {
                _local_2 = _soundManager.musicController.getSongInfo(_local_3);
                if (_local_2.soundObject != null)
                {
                    _local_2.soundObject.fadeOutSeconds = 0;
                };
            };
        }

        private function onSelectProduct(_arg_1:SelectProductEvent):void
        {
            if (((_arg_1 == null) || (_arg_1.offer == null)))
            {
                return;
            };
            var _local_2:IProduct = _arg_1.offer.product;
            if (_local_2.extraParam.length > 0)
            {
                _SafeStr_1618 = parseInt(_local_2.extraParam);
                if (_SafeStr_1618 == 0)
                {
                    _officialSongId = _local_2.extraParam;
                    if (_connection)
                    {
                        _connection.send(new GetOfficialSongIdMessageComposer(_officialSongId));
                    };
                };
                if (_playPreviewContainer != null)
                {
                    _playPreviewContainer.visible = true;
                };
            }
            else
            {
                _SafeStr_1618 = -1;
            };
            updateView();
        }

        private function updateView():void
        {
            var _local_1:int;
            var _local_4:int;
            var _local_8:String;
            var _local_6:String;
            var _local_3:IHabboLocalizationManager;
            var _local_7:String;
            var _local_2:Boolean;
            var _local_5:int = getSongLength();
            if (_local_5 >= 0)
            {
                _local_1 = int((_local_5 / 60));
                _local_4 = (_local_5 % 60);
                _local_8 = ("" + _local_1);
                _local_6 = ("" + _local_4);
                if (_local_4 < 10)
                {
                    _local_6 = ("0" + _local_6);
                };
                _local_3 = (page.viewer.catalog as HabboCatalog).localization;
                _local_3.registerParameter("catalog.song.length", "min", _local_8);
                _local_7 = _local_3.registerParameter("catalog.song.length", "sec", _local_6);
                _local_2 = true;
                if (_SafeStr_1617 != null)
                {
                    _SafeStr_1617.caption = _local_7;
                };
            }
            else
            {
                if (_SafeStr_1617 != null)
                {
                    _SafeStr_1617.caption = "";
                };
            };
            if (_playButton != null)
            {
                if (_local_2)
                {
                    _playButton.enable();
                }
                else
                {
                    _playButton.disable();
                };
            };
        }

        private function getSongLength():int
        {
            var _local_1:ISongInfo;
            if (((!(_soundManager == null)) && (!(_soundManager.musicController == null))))
            {
                _local_1 = _soundManager.musicController.getSongInfo(_SafeStr_1618);
                if (_local_1 != null)
                {
                    return (_local_1.length / 1000);
                };
                _soundManager.musicController.requestSongInfoWithoutSamples(_SafeStr_1618);
            };
            return (-1);
        }

        private function onSongInfoReceivedEvent(_arg_1:SongInfoReceivedEvent):void
        {
            if (_arg_1.id == _SafeStr_1618)
            {
                updateView();
            };
        }

        private function onOfficialSongIdMessageEvent(_arg_1:OfficialSongIdMessageEvent):void
        {
            if (_arg_1.getParser().officialSongId == _officialSongId)
            {
                _SafeStr_1618 = _arg_1.getParser().songId;
                updateView();
            };
        }


    }
}


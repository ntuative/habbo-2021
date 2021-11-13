package com.sulake.habbo.ui.widget
{
    import com.sulake.habbo.ui.IRoomWidgetFactory;
    import com.sulake.habbo.ui.RoomUI;
    import com.sulake.core.assets.IAssetLibrary;
    import com.sulake.habbo.window.IHabboWindowManager;
    import com.sulake.habbo.ui.widget.roomchat.RoomChatWidget;
    import com.sulake.habbo.ui.widget.chatinput.RoomChatInputWidget;
    import com.sulake.habbo.ui.widget.infostand.InfoStandWidget;
    import com.sulake.habbo.ui.widget.memenu.MeMenuWidget;
    import com.sulake.habbo.ui.widget.furniture.placeholder.PlaceholderWidget;
    import com.sulake.habbo.ui.widget.furniture.credit.CreditFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.stickie.StickieFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.present.PresentFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.trophy.TrophyFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.trophy.AchievementResolutionTrophyFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.ecotronbox.EcotronBoxFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.petpackage.PetPackageFurniWidget;
    import com.sulake.habbo.ui.widget.doorbell.DoorbellWidget;
    import com.sulake.habbo.ui.widget.loadingbar.LoadingBarWidget;
    import com.sulake.habbo.ui.widget.roomqueue.RoomQueueWidget;
    import com.sulake.habbo.ui.widget.poll.PollWidget;
    import com.sulake.habbo.ui.widget.chooser.UserChooserWidget;
    import com.sulake.habbo.ui.widget.chooser.FurniChooserWidget;
    import com.sulake.habbo.ui.widget.furniture.dimmer.DimmerFurniWidget;
    import com.sulake.habbo.ui.widget.friendrequest.FriendRequestWidget;
    import com.sulake.habbo.ui.widget.furniture.clothingchange.ClothingChangeFurnitureWidget;
    import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
    import com.sulake.habbo.ui.widget.playlisteditor.PlayListEditorWidget;
    import com.sulake.habbo.ui.widget.furniture.stickie.SpamWallPostItFurniWidget;
    import com.sulake.habbo.ui.widget.effects.EffectsWidget;
    import com.sulake.habbo.ui.widget.furniture.mannequin.MannequinWidget;
    import com.sulake.habbo.ui.widget.furniture.contextmenu.FurnitureContextMenuWidget;
    import com.sulake.habbo.ui.widget.camera.CameraWidget;
    import com.sulake.habbo.ui.widget.furniture.backgroundcolor.BackgroundColorFurniWidget;
    import com.sulake.habbo.ui.widget.furniture.requirementsmissing.CustomUserNotificationWidget;
    import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniConfirmWidget;
    import com.sulake.habbo.ui.widget.furniture.friendfurni.FriendFurniEngravingWidget;
    import com.sulake.habbo.ui.widget.furniture.highscore.HighScoreDisplayWidget;
    import com.sulake.habbo.ui.widget.furniture.CustomStackHeightWidget;
    import com.sulake.habbo.ui.widget.furniture.video.YoutubeDisplayWidget;
    import com.sulake.habbo.ui.widget.furniture.rentablespace.RentableSpaceDisplayWidget;
    import com.sulake.habbo.ui.widget.furniture.video.VimeoDisplayWidget;
    import com.sulake.habbo.ui.widget.roomtools.RoomToolsWidget;
    import com.sulake.habbo.ui.widget.furniture.externalimage.ExternalImageWidget;
    import com.sulake.habbo.ui.widget.wordquiz.WordQuizWidget;
    import com.sulake.habbo.ui.widget.uihelpbubbles.UiHelpBubblesWidget;
    import com.sulake.habbo.ui.widget.camera.RoomThumbnailCameraWidget;
    import com.sulake.habbo.ui.widget.furniture.roomlink.FurnitureRoomLinkWidget;
    import com.sulake.habbo.ui.widget.crafting.CraftingWidget;
    import com.sulake.habbo.ui.IRoomWidgetHandler;

    public class RoomWidgetFactory implements IRoomWidgetFactory 
    {

        private var _roomUI:RoomUI;
        private var _SafeStr_514:int = 0;

        public function RoomWidgetFactory(_arg_1:RoomUI)
        {
            _roomUI = _arg_1;
        }

        public function dispose():void
        {
            _roomUI = null;
        }

        public function createWidget(_arg_1:String, _arg_2:IRoomWidgetHandler):IRoomWidget
        {
            if (((_roomUI == null) || (_roomUI.windowManager == null)))
            {
                return (null);
            };
            var _local_3:IAssetLibrary = _roomUI.assets;
            var _local_4:IHabboWindowManager = _roomUI.windowManager;
            switch (_arg_1)
            {
                case "RWE_CHAT_WIDGET":
                    return (new RoomChatWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI, _SafeStr_514++, _roomUI));
                case "RWE_CHAT_INPUT_WIDGET":
                    return (new RoomChatInputWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI, _roomUI.getDesktop("hard_coded_room_id")));
                case "RWE_INFOSTAND":
                    return (new InfoStandWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI, _roomUI.catalog));
                case "RWE_ME_MENU":
                    return (new MeMenuWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI));
                case "RWE_FURNI_PLACEHOLDER":
                    return (new PlaceholderWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_FURNI_CREDIT_WIDGET":
                    return (new CreditFurniWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_FURNI_STICKIE_WIDGET":
                    return (new StickieFurniWidget(_arg_2, _local_4, _local_3));
                case "RWE_FURNI_PRESENT_WIDGET":
                    return (new PresentFurniWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI, _roomUI.catalog, _roomUI.inventory, _roomUI.roomEngine));
                case "RWE_FURNI_TROPHY_WIDGET":
                    return (new TrophyFurniWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI));
                case "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                    return (new AchievementResolutionTrophyFurniWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI));
                case "RWE_FURNI_ECOTRONBOX_WIDGET":
                    return (new EcotronBoxFurniWidget(_arg_2, _local_4, _local_3));
                case "RWE_FURNI_PET_PACKAGE_WIDGET":
                    return (new PetPackageFurniWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_DOORBELL":
                    return (new DoorbellWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_LOADINGBAR":
                    return (new LoadingBarWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI));
                case "RWE_ROOM_QUEUE":
                    return (new RoomQueueWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI));
                case "RWE_ROOM_POLL":
                    return (new PollWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_USER_CHOOSER":
                    return (new UserChooserWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_FURNI_CHOOSER":
                    return (new FurniChooserWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_ROOM_DIMMER":
                    return (new DimmerFurniWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_FRIEND_REQUEST":
                    return (new FriendRequestWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI));
                case "RWE_CLOTHING_CHANGE":
                    return (new ClothingChangeFurnitureWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_CONVERSION_TRACKING":
                    return (new RoomWidgetBase(_arg_2, _local_4));
                case "RWE_AVATAR_INFO":
                    return (new AvatarInfoWidget(_arg_2, _local_4, _local_3, _roomUI, _roomUI.localization, _roomUI, _roomUI.catalog));
                case "RWE_PLAYLIST_EDITOR_WIDGET":
                    return (new PlayListEditorWidget(_arg_2, _local_4, _roomUI.soundManager, _local_3, _roomUI.localization, _roomUI, _roomUI.catalog));
                case "RWE_SPAMWALL_POSTIT_WIDGET":
                    return (new SpamWallPostItFurniWidget(_arg_2, _local_4, _local_3));
                case "RWE_EFFECTS":
                    return (new EffectsWidget(_arg_2, _local_4, _local_3));
                case "RWE_MANNEQUIN":
                    return (new MannequinWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_FURNITURE_CONTEXT_MENU":
                    return (new FurnitureContextMenuWidget(_arg_2, _local_4, _local_3, _roomUI, _roomUI.localization, _roomUI, _roomUI.habboGroupsManager, _roomUI.catalog));
                case "RWE_CAMERA":
                    return (new CameraWidget(_arg_2, _local_4, _local_3, _roomUI, _roomUI.localization, _roomUI));
                case "RWE_ROOM_BACKGROUND_COLOR":
                    return (new BackgroundColorFurniWidget(_arg_2, _local_4, _local_3));
                case "RWE_CUSTOM_USER_NOTIFICATION":
                    return (new CustomUserNotificationWidget(_arg_2, _local_4, _local_3));
                case "RWE_FRIEND_FURNI_CONFIRM":
                    return (new FriendFurniConfirmWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_FRIEND_FURNI_ENGRAVING":
                    return (new FriendFurniEngravingWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_HIGH_SCORE_DISPLAY":
                    return (new HighScoreDisplayWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_CUSTOM_STACK_HEIGHT":
                    return (new CustomStackHeightWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_YOUTUBE":
                    return (new YoutubeDisplayWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI.habboTracking));
                case "RWE_RENTABLESPACE":
                    return (new RentableSpaceDisplayWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_VIMEO":
                    return (new VimeoDisplayWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_ROOM_TOOLS":
                    return (new RoomToolsWidget(_arg_2, _local_4, _local_3, _roomUI));
                case "RWE_EXTERNAL_IMAGE":
                    return (new ExternalImageWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI.inventory, _roomUI.habboHelp, _roomUI.roomEngine, _roomUI));
                case "RWE_WORD_QUIZZ":
                    return (new WordQuizWidget(_arg_2, _local_4, _local_3, _roomUI.localization));
                case "RWE_UI_HELP_BUBBLE":
                    return (new UiHelpBubblesWidget(_arg_2, _local_4, _local_3, _roomUI.localization, _roomUI.friendBarView, _roomUI.toolbar, _roomUI.getDesktop("hard_coded_room_id"), _roomUI));
                case "RWE_ROOM_THUMBNAIL_CAMERA":
                    return (new RoomThumbnailCameraWidget(_arg_2, _local_4, _local_3, _roomUI, _roomUI.localization, _roomUI));
                case "RWE_ROOM_LINK":
                    return (new FurnitureRoomLinkWidget(_arg_2, _local_4));
                case "RWE_CRAFTING":
                    return (new CraftingWidget(_arg_2, _local_4, _roomUI));
            };
            return (null);
        }

        public function get disposed():Boolean
        {
            return (_roomUI == null);
        }


    }
}


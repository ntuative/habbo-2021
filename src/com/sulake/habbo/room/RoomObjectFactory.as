package com.sulake.habbo.room
{
    import com.sulake.core.runtime.Component;
    import com.sulake.room.IRoomObjectFactory;
    import com.sulake.core.utils.Map;
    import com.sulake.core.runtime.IContext;
    import com.sulake.room.object.logic.IRoomObjectEventHandler;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiStateLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMultiHeightLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlaceholderLogic;
    import com.sulake.habbo.room.object.logic.AvatarLogic;
    import com.sulake.habbo.room.object.logic.PetLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRandomStateLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCreditLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureStickieLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureExternalImageLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePresentLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureTrophyLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEcotronBoxLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureDiceLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHockeyScoreLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHabboWheelLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureOneWayDoorLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePlanetSystemLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_122;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomDimmerLogic;
    import com.sulake.habbo.room.object.logic.room.RoomTileCursorLogic;
    import com.sulake.habbo.room.object.logic.room._SafeStr_128;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundMachineLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureJukeboxLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_109;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSongDiskLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePushableLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureClothingChangeLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_146;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureScoreBoardLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureIceStormLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureFireworksLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBillboardLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBackgroundLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureWelcomeGiftLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureFloorHoleLogic;
    import com.sulake.habbo.room.object.logic.room.RoomLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMannequinLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureGuildCustomizedLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_110;
    import com.sulake.habbo.room.object.logic.furniture.FurniturePetProductLogic;
    import com.sulake.habbo.room.object.logic.game.SnowballLogic;
    import com.sulake.habbo.room.object.logic.game._SafeStr_107;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureCuckooClockLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureVoteCounterLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_136;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureSoundBlockLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_130;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_123;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_103;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureRoomBackgroundColorLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_106;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_105;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureMysteryTrophyLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureAchievementResolutionLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_135;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_113;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_152;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_111;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureHighScoreLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureInternalLinkLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEditableInternalLinkLogic;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureEditableRoomLinkLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_121;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_151;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_149;
    import com.sulake.habbo.room.object.logic.furniture.FurnitureChangeStateWhenStepOnLogic;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_133;
    import com.sulake.habbo.room.object.logic.furniture._SafeStr_138;
    import com.sulake.room.RoomObjectManager;
    import com.sulake.room.IRoomObjectManager;

    public class RoomObjectFactory extends Component implements IRoomObjectFactory 
    {

        private var _SafeStr_479:Map = new Map();
        private var _SafeStr_478:Map = new Map();
        private var _objectEventListeners:Array = [];

        public function RoomObjectFactory(_arg_1:IContext, _arg_2:uint=0)
        {
            super(_arg_1, _arg_2);
        }

        public function addObjectEventListener(_arg_1:Function):void
        {
            var _local_2:String;
            if (_objectEventListeners.indexOf(_arg_1) < 0)
            {
                _objectEventListeners.push(_arg_1);
                if (_arg_1 != null)
                {
                    for each (_local_2 in _SafeStr_478.getKeys())
                    {
                        events.addEventListener(_local_2, _arg_1);
                    };
                };
            };
        }

        public function removeObjectEventListener(_arg_1:Function):void
        {
            var _local_3:String;
            var _local_2:int = _objectEventListeners.indexOf(_arg_1);
            if (_local_2 >= 0)
            {
                _objectEventListeners.splice(_local_2, 1);
                if (_arg_1 != null)
                {
                    for each (_local_3 in _SafeStr_478.getKeys())
                    {
                        events.removeEventListener(_local_3, _arg_1);
                    };
                };
            };
        }

        private function addTrackedEventType(_arg_1:String):void
        {
            if (_SafeStr_478.getValue(_arg_1) == null)
            {
                _SafeStr_478.add(_arg_1, true);
                for each (var _local_2:Function in _objectEventListeners)
                {
                    if (_local_2 != null)
                    {
                        events.addEventListener(_arg_1, _local_2);
                    };
                };
            };
        }

        public function createRoomObjectLogic(_arg_1:String):IRoomObjectEventHandler
        {
            var _local_6:IRoomObjectEventHandler;
            var _local_2:Array;
            var _local_3:Class;
            switch (_arg_1)
            {
                case "furniture_basic":
                    _local_3 = FurnitureLogic;
                    break;
                case "furniture_multistate":
                    _local_3 = FurnitureMultiStateLogic;
                    break;
                case "furniture_multiheight":
                    _local_3 = FurnitureMultiHeightLogic;
                    break;
                case "furniture_placeholder":
                    _local_3 = FurniturePlaceholderLogic;
                    break;
                case "user":
                case "bot":
                case "rentable_bot":
                    _local_3 = AvatarLogic;
                    break;
                case "pet":
                    _local_3 = PetLogic;
                    break;
                case "furniture_randomstate":
                    _local_3 = FurnitureRandomStateLogic;
                    break;
                case "furniture_credit":
                    _local_3 = FurnitureCreditLogic;
                    break;
                case "furniture_stickie":
                    _local_3 = FurnitureStickieLogic;
                    break;
                case "furniture_external_image_wallitem":
                    _local_3 = FurnitureExternalImageLogic;
                    break;
                case "furniture_present":
                    _local_3 = FurniturePresentLogic;
                    break;
                case "furniture_trophy":
                    _local_3 = FurnitureTrophyLogic;
                    break;
                case "furniture_ecotron_box":
                    _local_3 = FurnitureEcotronBoxLogic;
                    break;
                case "furniture_dice":
                    _local_3 = FurnitureDiceLogic;
                    break;
                case "furniture_hockey_score":
                    _local_3 = FurnitureHockeyScoreLogic;
                    break;
                case "furniture_habbowheel":
                    _local_3 = FurnitureHabboWheelLogic;
                    break;
                case "furniture_one_way_door":
                    _local_3 = FurnitureOneWayDoorLogic;
                    break;
                case "furniture_planet_system":
                    _local_3 = FurniturePlanetSystemLogic;
                    break;
                case "furniture_window":
                    _local_3 = _SafeStr_122;
                    break;
                case "furniture_roomdimmer":
                    _local_3 = FurnitureRoomDimmerLogic;
                    break;
                case "tile_cursor":
                    _local_3 = RoomTileCursorLogic;
                    break;
                case "selection_arrow":
                    _local_3 = _SafeStr_128;
                    break;
                case "furniture_sound_machine":
                    _local_3 = FurnitureSoundMachineLogic;
                    break;
                case "furniture_jukebox":
                    _local_3 = FurnitureJukeboxLogic;
                    break;
                case "furniture_crackable":
                    _local_3 = _SafeStr_109;
                    break;
                case "furniture_song_disk":
                    _local_3 = FurnitureSongDiskLogic;
                    break;
                case "furniture_pushable":
                    _local_3 = FurniturePushableLogic;
                    break;
                case "furniture_clothing_change":
                    _local_3 = FurnitureClothingChangeLogic;
                    break;
                case "furniture_counter_clock":
                    _local_3 = _SafeStr_146;
                    break;
                case "furniture_score":
                    _local_3 = FurnitureScoreBoardLogic;
                    break;
                case "furniture_es":
                    _local_3 = FurnitureIceStormLogic;
                    break;
                case "furniture_fireworks":
                    _local_3 = FurnitureFireworksLogic;
                    break;
                case "furniture_bb":
                    _local_3 = FurnitureRoomBillboardLogic;
                    break;
                case "furniture_bg":
                    _local_3 = FurnitureRoomBackgroundLogic;
                    break;
                case "furniture_welcome_gift":
                    _local_3 = FurnitureWelcomeGiftLogic;
                    break;
                case "furniture_floor_hole":
                    _local_3 = FurnitureFloorHoleLogic;
                    break;
                case "room":
                    _local_3 = RoomLogic;
                    break;
                case "furniture_mannequin":
                    _local_3 = FurnitureMannequinLogic;
                    break;
                case "furniture_guild_customized":
                    _local_3 = FurnitureGuildCustomizedLogic;
                    break;
                case "furniture_group_forum_terminal":
                    _local_3 = _SafeStr_110;
                    break;
                case "furniture_pet_customization":
                    _local_3 = FurniturePetProductLogic;
                    break;
                case "game_snowball":
                    _local_3 = SnowballLogic;
                    break;
                case "game_snowsplash":
                    _local_3 = _SafeStr_107;
                    break;
                case "furniture_cuckoo_clock":
                    _local_3 = FurnitureCuckooClockLogic;
                    break;
                case "furniture_vote_counter":
                    _local_3 = FurnitureVoteCounterLogic;
                    break;
                case "furniture_vote_majority":
                    _local_3 = _SafeStr_136;
                    break;
                case "furniture_soundblock":
                    _local_3 = FurnitureSoundBlockLogic;
                    break;
                case "furniture_random_teleport":
                    _local_3 = _SafeStr_130;
                    break;
                case "furniture_monsterplant_seed":
                    _local_3 = _SafeStr_123;
                    break;
                case "furniture_purchasable_clothing":
                    _local_3 = _SafeStr_103;
                    break;
                case "furniture_background_color":
                    _local_3 = FurnitureRoomBackgroundColorLogic;
                    break;
                case "furniture_mysterybox":
                    _local_3 = _SafeStr_106;
                    break;
                case "furniture_effectbox":
                    _local_3 = _SafeStr_105;
                    break;
                case "furniture_mysterytrophy":
                    _local_3 = FurnitureMysteryTrophyLogic;
                    break;
                case "furniture_achievement_resolution":
                    _local_3 = FurnitureAchievementResolutionLogic;
                    break;
                case "furniture_lovelock":
                    _local_3 = _SafeStr_135;
                    break;
                case "furniture_wildwest_wanted":
                    _local_3 = _SafeStr_113;
                    break;
                case "furniture_hween_lovelock":
                    _local_3 = _SafeStr_152;
                    break;
                case "furniture_badge_display":
                    _local_3 = _SafeStr_111;
                    break;
                case "furniture_high_score":
                    _local_3 = FurnitureHighScoreLogic;
                    break;
                case "furniture_internal_link":
                    _local_3 = FurnitureInternalLinkLogic;
                    break;
                case "furniture_editable_internal_link":
                    _local_3 = FurnitureEditableInternalLinkLogic;
                    break;
                case "furniture_editable_room_link":
                    _local_3 = FurnitureEditableRoomLinkLogic;
                    break;
                case "furniture_custom_stack_height":
                    _local_3 = _SafeStr_121;
                    break;
                case "furniture_youtube":
                    _local_3 = _SafeStr_151;
                    break;
                case "furniture_rentable_space":
                    _local_3 = _SafeStr_149;
                    break;
                case "furniture_change_state_when_step_on":
                    _local_3 = FurnitureChangeStateWhenStepOnLogic;
                    break;
                case "furniture_vimeo":
                    _local_3 = _SafeStr_133;
                    break;
                case "furniture_crafting_gizmo":
                    _local_3 = _SafeStr_138;
            };
            if (_local_3 == null)
            {
                return (null);
            };
            var _local_4:Object = new _local_3();
            if ((_local_4 is IRoomObjectEventHandler))
            {
                _local_6 = (_local_4 as IRoomObjectEventHandler);
                _local_6.eventDispatcher = this.events;
                if (_SafeStr_479.getValue(_arg_1) == null)
                {
                    _SafeStr_479.add(_arg_1, true);
                    _local_2 = _local_6.getEventTypes();
                    for each (var _local_5:String in _local_2)
                    {
                        addTrackedEventType(_local_5);
                    };
                };
                return (_local_6);
            };
            return (null);
        }

        public function createRoomObjectManager():IRoomObjectManager
        {
            return (new RoomObjectManager());
        }


    }
}


//hvp
//kidbrazil
//mcrow
//ninjonas
//tominabx
#include QMK_KEYBOARD_H
#include "bootloader.h"
#ifdef PROTOCOL_LUFA
  #include "lufa.h"
  #include "split_util.h"
#endif
#ifdef SSD1306OLED
  #include "ssd1306.h"
#endif

extern keymap_config_t keymap_config;

#ifdef RGBLIGHT_ENABLE
//Following line allows macro to read current RGB settings
extern rgblight_config_t rgblight_config;
#endif

extern uint8_t is_master;


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.

enum layers {
    _DEFAULTS = 0,
    _DVORAK = 0,
    _QWERTY,
    _LOWER,
    _RAISE,
    _ADJUST,
    _LAUNCH
};


enum custom_keycodes {
  DVORAK= SAFE_RANGE,
  QWERTY, 
  LOWER,
  RAISE,
  ADJUST,
  LAUNCH,
  BACKLIT,
  RGBRST
};

enum {
    TD_CAPLOCK,
    TD_ALT,
    TD_SUPER,
    TD_DOLLAR,
    TD_BCK
};

enum macro_keycodes {
  KC_SAMPLEMACRO,
};

#define XXXXXX   KC_NO 
#define CTLTB CTL_T(KC_TAB)
#define RSHIFT TD(TD_CAPLOCK)
#define KC_LCH LT(LAUNCH, KC_SPC) 
#define SUPER TD(TD_SUPER)
#define TD_DLR TD(TD_DOLLAR)

#define KC______ KC_TRNS

#define KC_ALT TD(TD_ALT)
#define KC_BCK TD(TD_BCK)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  [_DVORAK] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       KC_ESC, KC_SCLN, KC_COMM,  KC_DOT,    KC_P,    KC_Y,                     KC_F,    KC_G,    KC_C,    KC_R,    KC_L,  KC_BCK,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        CTLTB,    KC_A,    KC_O,    KC_E,    KC_U,    KC_I,                     KC_D,    KC_H,    KC_T,    KC_N,    KC_S, KC_MINS,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_LSFT, KC_QUOT,    KC_Q,    KC_J,    KC_K,    KC_X,                     KC_B,    KC_M,    KC_W,    KC_V,    KC_Z, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_LCH,                   KC_ENT,   RAISE,  KC_ALT
  //                           '--------------------------'                '--------------------------'
  ),

  [_QWERTY] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       KC_ESC,    KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                     KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,  KC_BCK,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        CTLTB,    KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                     KC_H,    KC_J,    KC_K,    KC_L, KC_SCLN, KC_QUOT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_LSFT,    KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                     KC_N,    KC_M, KC_COMM,  KC_DOT, KC_SLSH, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  ),

  [_LOWER] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       KC_ESC, KC_LBRC, KC_LCBR, KC_RCBR, KC_LPRN,  KC_EQL,                  KC_PAST, KC_RPRN, KC_PLUS, KC_RBRC, KC_EXLM, KC_BSPC,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       TD_DLR, KC_PGUP, KC_PGDN, KC_HOME,  KC_END, KC_PSCR,                   KC_DEL, KC_LEFT, KC_DOWN,   KC_UP, KC_RGHT, KC_HASH,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        CTLTB, KC_MUTE, KC_VOLD, KC_VOLU, KC_MPLY, KC_CIRC,                   XXXXXX,  KC_GRV, KC_BSLS,   KC_AT, KC_SLSH,  RSHIFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
//                             '--------------------------'                '--------------------------'
  ),

  [_RAISE] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       XXXXXX,    KC_7,    KC_5,    KC_3,    KC_1,    KC_9,                     KC_0,     KC_2,   KC_4,    KC_6,    KC_8, KC_BSPC,  
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
        KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,                    KC_F7,   KC_F8,   KC_F9,  KC_F10,  KC_F11,  KC_F12,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      KC_RSFT,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX, KC_RSFT,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  ),

  [_ADJUST] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       RGBRST,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   DVORAK,  QWERTY,  XXXXXX,  XXXXXX,  XXXXXX,  KC_PWR,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      RGB_TOG, RGB_HUI, RGB_SAI, RGB_VAI,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,   RESET,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
      RGB_MOD, RGB_HUD, RGB_SAD, RGB_VAD, XXXXXX, XXXXXX,                     XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX , XXXXXX, KC_SLEP,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  ),

  [_LAUNCH] = LAYOUT(
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
       XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,                   XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,  XXXXXX,
  //|--------+--------+--------+--------+--------+--------|                |--------+--------+--------+--------+--------+--------|
                                   SUPER,   LOWER,  KC_SPC,                   KC_ENT,   RAISE,  KC_ALT  
  //                           '--------------------------'                '--------------------------'
  )
};



void back_tap(qk_tap_dance_state_t *state, void *user_data) { tap_code(KC_BSPACE); }

void back_finished(qk_tap_dance_state_t *state, void *user_data) { if(!(state->interrupted || !state->pressed)) tap_code16(LCTL(KC_BSPACE)); }

// Tap Dance definitions
qk_tap_dance_action_t tap_dance_actions[] = {
  [TD_ALT] = ACTION_TAP_DANCE_DOUBLE(KC_RALT, KC_LALT),
  [TD_CAPLOCK] = ACTION_TAP_DANCE_DOUBLE(KC_LSFT, KC_CAPS),
  //each tap, on finished, and reset. Normally register_code on press unregister on reset so keys can be held down:
  [TD_BCK] = ACTION_TAP_DANCE_FN_ADVANCED(back_tap, back_finished, NULL), 
  [TD_SUPER] = ACTION_TAP_DANCE_DOUBLE(KC_LGUI, KC_MEH),
  [TD_DOLLAR]= ACTION_TAP_DANCE_DOUBLE(KC_DLR, KC_TILD)
};

int RGB_current_mode;



const rgblight_segment_t PROGMEM layer_dvorak_lights[] = RGBLIGHT_LAYER_SEGMENTS( 
  {0, 10, HSV_AZURE}
);
const rgblight_segment_t PROGMEM layer_qwerty_lights[] = RGBLIGHT_LAYER_SEGMENTS(
  {0, 10, HSV_TEAL}
);
  
const rgblight_segment_t PROGMEM layer_raise_lights[] = RGBLIGHT_LAYER_SEGMENTS(
  {0, 10, HSV_PURPLE}
);
const rgblight_segment_t PROGMEM layer_lower_lights[] = RGBLIGHT_LAYER_SEGMENTS(
 {0, 10, HSV_ORANGE},
 {10, 5, HSV_BLUE},
 {15, 3, HSV_BLUE},
 {18, 3, HSV_BLUE}
);
  
 const rgblight_segment_t PROGMEM layer_adjust_lights[] = RGBLIGHT_LAYER_SEGMENTS( 
    {0, 6, HSV_GREEN},
 	{9, 2, HSV_GREEN},
 	{17, 2, HSV_GREEN},
 	{23, 2, HSV_GREEN}
 );


const rgblight_segment_t PROGMEM layer_launch_lights[] = RGBLIGHT_LAYER_SEGMENTS(
    {0, 10, HSV_RED}
);
 // Now define the array of layers. Later layers take precedence
const rgblight_segment_t* const PROGMEM my_rgb_layers[] = RGBLIGHT_LAYERS_LIST(
  layer_dvorak_lights, 
  layer_qwerty_lights, 
  layer_lower_lights,
  layer_raise_lights,
  layer_adjust_lights,
  layer_launch_lights
);

void keyboard_post_init_user(void) {
// Enable the LED layers
  rgblight_layers = my_rgb_layers;
  rgblight_mode(10);// haven't found a way to set this in a more useful way 

}

layer_state_t layer_state_set_user(layer_state_t state) {
    rgblight_set_layer_state(_DVORAK, layer_state_cmp(state, _DEFAULTS) && layer_state_cmp(default_layer_state,_DVORAK));
    rgblight_set_layer_state(_QWERTY, layer_state_cmp(state, _DEFAULTS) && layer_state_cmp(default_layer_state,_QWERTY));
    rgblight_set_layer_state(_LOWER, layer_state_cmp(state, _RAISE));
    rgblight_set_layer_state(_RAISE, layer_state_cmp(state, _LOWER));
    rgblight_set_layer_state(_ADJUST, layer_state_cmp(state, _ADJUST));
    rgblight_set_layer_state(_LAUNCH, layer_state_cmp(state, _LAUNCH));
    return state;
}
bool led_update_user(led_t led_state) {
    rgblight_set_layer_state(0, led_state.caps_lock);
    return true;
}









// Setting ADJUST layer RGB back to default
void update_tri_layer_RGB(uint8_t layer1, uint8_t layer2, uint8_t layer3) {
  if (IS_LAYER_ON(layer1) && IS_LAYER_ON(layer2)) {
    layer_on(layer3);
  } else {
    layer_off(layer3);
  }
}

void matrix_init_user(void) {
    #ifdef RGBLIGHT_ENABLE
      RGB_current_mode = rgblight_config.mode;
    #endif
//#ifdef SSD1306OLED
//iota_gfx_init();   // turns on the display
//#endif
}

//SSD1306 OLED update loop, make sure to add #define SSD1306OLED in config.h
#ifdef SSD1306OLED

// When add source files to SRC in rules.mk, you can use functions.
const char *read_layer_state(void);
const char *read_logo(void);
void set_keylog(uint16_t keycode, keyrecord_t *record);
const char *read_keylog(void);
const char *read_keylogs(void);

// const char *read_mode_icon(bool swap);
// const char *read_host_led_state(void);
// void set_timelog(void);
// const char *read_timelog(void);

void matrix_render_user(struct CharacterMatrix *matrix) {
  if (is_keyboard_master()) {
    matrix_write(matrix, read_layer_state());
    matrix_write(matrix, read_keylog());
  } else {
    matrix_write(matrix, read_logo());
  }
}

void matrix_update(struct CharacterMatrix *dest, const struct CharacterMatrix *source) {
  if (memcmp(dest->display, source->display, sizeof(dest->display))) {
    memcpy(dest->display, source->display, sizeof(dest->display));
    dest->dirty = true;
  }
}

void iota_gfx_task_user(void) {
  struct CharacterMatrix matrix;
  matrix_clear(&matrix);
  matrix_render_user(&matrix);
  matrix_update(&display, &matrix);
}
#endif  //SSD1306OLED


void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}
bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (record->event.pressed) {
    #ifdef SSD1306OLED
//set_keylog(keycode, record);
    #endif
  }

  switch (keycode) {
    case DVORAK:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_DVORAK);
      }
      return false;
      break;
    case QWERTY:
      if (record->event.pressed) {
        persistent_default_layer_set(1UL<<_QWERTY);
      }
      return false;
      break;
    case LOWER:
      if (record->event.pressed) {
        layer_on(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_LOWER);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
      break;
    case RAISE:
      if (record->event.pressed) {
        layer_on(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      } else {
        layer_off(_RAISE);
        update_tri_layer_RGB(_LOWER, _RAISE, _ADJUST);
      }
      return false;
      break;
    case ADJUST:
        if (record->event.pressed) {
          layer_on(_ADJUST);
        } else {
          layer_off(_ADJUST);
        }
        return false;
        break;
    case LAUNCH:
        if (record->event.pressed) {
          layer_on(_LAUNCH);
        } else {
          layer_off(_LAUNCH);
        }
        return false;
        break;
    case RGB_MOD:
      #ifdef RGBLIGHT_ENABLE
        if (record->event.pressed) {
          rgblight_mode(RGB_current_mode);
          rgblight_step();
          RGB_current_mode = rgblight_config.mode;
        }
      #endif
      return false;
      break;
    case RGBRST:
      #ifdef RGBLIGHT_ENABLE
        if (record->event.pressed) {
          eeconfig_update_rgblight_default();
          rgblight_enable();
          RGB_current_mode = rgblight_config.mode;
        }
      #endif
      break;
  }
  return true;
}

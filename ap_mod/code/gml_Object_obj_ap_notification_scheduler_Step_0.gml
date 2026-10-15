if (!instance_exists(obj_helpful_text)) {
    timer -= 1;
    if (timer <= 0) {
        helpful_text_display_raw(text);
        instance_destroy();
    }
}
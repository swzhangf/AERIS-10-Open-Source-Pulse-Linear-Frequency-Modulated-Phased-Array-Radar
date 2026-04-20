#ifndef USBHANDLER_H
#define USBHANDLER_H

#include "RadarSettings.h"
#include <cstdint>

class USBHandler {
public:
    enum class USBState {
        WAITING_FOR_START,
        RECEIVING_SETTINGS,
        READY_FOR_DATA
    };
    
    USBHandler();
    
    // Process incoming USB data
    void processUSBData(const uint8_t* data, uint32_t length);
    
    // Check if start flag was received
    bool isStartFlagReceived() const { return start_flag_received; }
    
    // Get current settings
    const RadarSettings& getSettings() const { return current_settings; }
    
    // Get current state
    USBState getState() const { return current_state; }
    
    // Reset USB handler
    void reset();

private:
    RadarSettings current_settings;
    USBState current_state;
    bool start_flag_received;
    
    // Buffer for accumulating USB data
    static constexpr uint32_t MAX_BUFFER_SIZE = 256;
    uint8_t usb_buffer[MAX_BUFFER_SIZE];
    uint32_t buffer_index;
    
    void processStartFlag(const uint8_t* data, uint32_t length);
    void processSettingsData(const uint8_t* data, uint32_t length);
};

#endif // USBHANDLER_H
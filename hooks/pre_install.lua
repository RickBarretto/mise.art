-- Returns download information for a specific version
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#preinstall-hook

function PLUGIN:PreInstall(ctx)
    local version = ctx.version
    -- ctx.runtimeVersion contains the full version string if needed

    local platform = get_platform() -- Uncomment the helper function above
    local url = "https://github.com/arturo-lang/arturo/releases/download/v" .. version .. "/arturo-" .. version .. "-" .. platform .. ".zip"

    return {
        version = version,
        url = url,
        note = "Downloading arturo " .. version,
    }
end

-- Helper function for platform detection (uncomment and modify as needed)
local function get_platform()
    -- RUNTIME object is provided by mise/vfox
    -- RUNTIME.osType: "Windows", "Linux", "Darwin"
    -- RUNTIME.archType: "amd64", "386", "arm64", etc.

    local os_name = RUNTIME.osType:lower()
    local arch = RUNTIME.archType

    local platform_map = {
        ["darwin"] = {
            ["amd64"] = "macos-amd64",
            ["arm64"] = "macos-arm64",
        },
        ["linux"] = {
            ["amd64"] = "linux-amd64",
            ["arm64"] = "linux-arm64",
        },
        ["windows"] = {
            ["amd64"] = "windows-amd64",
        }
    }

    -- Default fallback
    local os_map = platform_map[os_name]
    if os_map then
        return os_map[arch] or "linux-amd64"
    end
    return "linux-amd64"

end

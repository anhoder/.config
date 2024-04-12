function active_php
    sed -i -e 's/isActive(){/isActive() {return true;/g' $argv[1]
    sed -i -e 's/isRevoked(){/isRevoked() {return false;/g' $argv[1]
    sed -i -e 's/isExpired(){/isExpired() {return false;/g' $argv[1]
end
